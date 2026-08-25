#!/usr/bin/env bash
# Download the latest stable prebuilt archives for a small CLI toolset.
# Supported hosts: Linux/macOS on x86_64 or aarch64/arm64.
# Usage:
#   ./fetch-tool.bash <target> [destination]
#   ./fetch-tool.bash --help
#
# Targets: bottom, fd, fzf, ripgrep, tree-sitter, zoxide, neovim,
#          nushell, opencode, deja-vu, zellij
#
# The script only downloads archives; it does not extract or install them.
# Downloader preference: wget, then curl.

set -uo pipefail

usage() {
    printf 'Usage: %s <target> [destination]\n' "$0"
    printf 'Targets: bottom fd fzf ripgrep tree-sitter zoxide neovim nushell opencode deja-vu zellij\n'
}

if [[ "$#" -eq 1 && ( "$1" == "-h" || "$1" == "--help" ) ]]; then
    usage
    exit 0
fi

if [[ "$#" -lt 1 || "$#" -gt 2 ]]; then
    usage >&2
    exit 2
fi

TARGET="$1"
case "$TARGET" in
    bottom|fd|fzf|ripgrep|tree-sitter|zoxide|neovim|nushell|opencode|deja-vu|zellij)
        ;;
    *)
        echo "Error: unsupported target: $TARGET" >&2
        usage >&2
        exit 2
        ;;
esac

DEST_DIR="${2:-.}"
mkdir -p "$DEST_DIR"

if command -v wget >/dev/null 2>&1; then
    DOWNLOADER="wget"
elif command -v curl >/dev/null 2>&1; then
    DOWNLOADER="curl"
else
    echo "Error: neither wget nor curl is available." >&2
    exit 1
fi

case "$(uname -s)" in
    Linux)  OS="linux" ;;
    Darwin) OS="macos" ;;
    *)
        echo "Error: unsupported OS: $(uname -s)" >&2
        exit 1
        ;;
esac

case "$(uname -m)" in
    x86_64|amd64) ARCH="x86_64" ;;
    arm64|aarch64) ARCH="aarch64" ;;
    *)
        echo "Error: unsupported architecture: $(uname -m)" >&2
        exit 1
        ;;
esac

OK=0
SKIP=0
FAIL=0

fetch_text() {
    local url="$1"
    if [[ "$DOWNLOADER" == "wget" ]]; then
        wget -qO- "$url"
    else
        curl -fsSL "$url"
    fi
}

download_file() {
    local url="$1"
    local path="$2"

    rm -f "$path"
    if [[ "$DOWNLOADER" == "wget" ]]; then
        wget -O "$path" "$url"
    else
        curl -fL --progress-bar -o "$path" "$url"
    fi
}

validate_archive() {
    local path="$1"

    case "$path" in
        *.tar.gz|*.tgz)
            if command -v tar >/dev/null 2>&1; then
                tar -tzf "$path" >/dev/null 2>&1
            else
                return 0
            fi
            ;;
        *.zip)
            if command -v unzip >/dev/null 2>&1; then
                unzip -tq "$path" >/dev/null 2>&1
            else
                return 0
            fi
            ;;
        *.gz)
            if command -v gzip >/dev/null 2>&1; then
                gzip -t "$path" >/dev/null 2>&1
            else
                return 0
            fi
            ;;
        *)
            return 0
            ;;
    esac
}

release_urls() {
    # GitHub's /releases/latest endpoint returns the latest non-draft,
    # non-prerelease release. Avoid jq so this remains a bootstrap script.
    local repo="$1"
    local json

    json="$(fetch_text "https://api.github.com/repos/${repo}/releases/latest")" || return 1

    printf '%s\n' "$json" \
        | grep -oE '"browser_download_url"[[:space:]]*:[[:space:]]*"[^"]+"' \
        | cut -d '"' -f 4
}

download_release_asset() {
    local name="$1"
    [[ "$name" == "$TARGET" ]] || return 0

    local repo="$2"
    shift 2
    local patterns=("$@")

    local release_url="https://api.github.com/repos/${repo}/releases/latest"
    local pattern url filename path candidate
    local candidate_count=0
    local urls
    if ! urls="$(release_urls "$repo")"; then
        echo "[FAIL] $name: could not query latest release for $repo" >&2
        for pattern in "${patterns[@]}"; do
            if [[ "$pattern" == *'*'* || "$pattern" == *'['* ]]; then
                continue
            fi

            candidate="${pattern#^}"
            candidate="${candidate%\$}"
            candidate="${candidate//\\./.}"
            echo "       Candidate URL: https://github.com/${repo}/releases/latest/download/${candidate}" >&2
            candidate_count=$((candidate_count + 1))
        done

        if [[ "$candidate_count" -eq 0 ]]; then
            echo "       Candidate URL: $release_url" >&2
        fi
        FAIL=$((FAIL + 1))
        return
    fi

    local found=0

    for pattern in "${patterns[@]}"; do
        url="$(printf '%s\n' "$urls" | grep -E "$pattern" | head -n 1 || true)"
        [[ -n "$url" ]] || continue
        found=1

        filename="${url##*/}"
        path="${DEST_DIR%/}/$filename"

        echo
        echo "[$name] $filename"
        if ! download_file "$url" "$path"; then
            echo "[WARN] $name: download failed for $filename; trying fallback if available." >&2
            echo "       Candidate URL: $url" >&2
            rm -f "$path"
            continue
        fi

        if ! validate_archive "$path"; then
            echo "[WARN] $name: archive validation failed for $filename; trying fallback if available." >&2
            echo "       Candidate URL: $url" >&2
            rm -f "$path"
            continue
        fi

        echo "[OK]   $name -> $path"
        OK=$((OK + 1))
        return
    done

    if [[ "$found" -eq 0 ]]; then
        echo "[SKIP] $name: no native release asset for ${OS}/${ARCH}"
        echo "       Candidate URL: $release_url"
        SKIP=$((SKIP + 1))
    else
        echo "[FAIL] $name: all matching assets failed to download/validate" >&2
        FAIL=$((FAIL + 1))
    fi
}

echo "Detected: ${OS}/${ARCH}"
echo "Downloader: ${DOWNLOADER}"
echo "Destination: ${DEST_DIR}"
echo "Target: ${TARGET}"

if [[ "$OS" == "linux" && "$ARCH" == "x86_64" ]]; then
    download_release_asset bottom ClementTsang/bottom \
        'bottom_x86_64-unknown-linux-musl\.tar\.gz$' \
        'bottom_x86_64-unknown-linux-gnu\.tar\.gz$'

    download_release_asset fd sharkdp/fd \
        'fd-v[^/]*-x86_64-unknown-linux-musl\.tar\.gz$' \
        'fd-v[^/]*-x86_64-unknown-linux-gnu\.tar\.gz$'

    download_release_asset fzf junegunn/fzf \
        'fzf-[^/]*-linux_amd64\.tar\.gz$'

    # Prefer musl. If a published musl archive is malformed, validation
    # automatically falls back to the GNU build.
    download_release_asset ripgrep BurntSushi/ripgrep \
        'ripgrep-[^/]*-x86_64-unknown-linux-musl\.tar\.gz$' \
        'ripgrep-[^/]*-x86_64-unknown-linux-gnu\.tar\.gz$'

    download_release_asset tree-sitter tree-sitter/tree-sitter \
        'tree-sitter-cli-linux-x64\.zip$' \
        'tree-sitter-linux-x64\.gz$'

    download_release_asset zoxide ajeetdsouza/zoxide \
        'zoxide-[^/]*-x86_64-unknown-linux-musl\.tar\.gz$' \
        'zoxide-[^/]*-x86_64-unknown-linux-gnu\.tar\.gz$'

    download_release_asset neovim neovim/neovim \
        'nvim-linux-x86_64\.tar\.gz$'

    download_release_asset nushell nushell/nushell \
        'nu-[^/]*-x86_64-unknown-linux-musl\.tar\.gz$' \
        'nu-[^/]*-x86_64-unknown-linux-gnu\.tar\.gz$'

    # Explicitly choose the normal x64 build, never *baseline*.
    download_release_asset opencode anomalyco/opencode \
        'opencode-linux-x64-musl\.tar\.gz$' \
        'opencode-linux-x64\.tar\.gz$'

    download_release_asset deja-vu vshulcz/deja-vu \
        'deja-vu_[^/]*_linux_amd64\.tar\.gz$'

    download_release_asset zellij zellij-org/zellij \
        'zellij-x86_64-unknown-linux-musl\.tar\.gz$'

elif [[ "$OS" == "linux" && "$ARCH" == "aarch64" ]]; then
    download_release_asset bottom ClementTsang/bottom \
        'bottom_aarch64-unknown-linux-musl\.tar\.gz$' \
        'bottom_aarch64-unknown-linux-gnu\.tar\.gz$'

    download_release_asset fd sharkdp/fd \
        'fd-v[^/]*-aarch64-unknown-linux-musl\.tar\.gz$' \
        'fd-v[^/]*-aarch64-unknown-linux-gnu\.tar\.gz$'

    download_release_asset fzf junegunn/fzf \
        'fzf-[^/]*-linux_arm64\.tar\.gz$'

    # ripgrep currently publishes GNU rather than musl for Linux ARM64.
    download_release_asset ripgrep BurntSushi/ripgrep \
        'ripgrep-[^/]*-aarch64-unknown-linux-musl\.tar\.gz$' \
        'ripgrep-[^/]*-aarch64-unknown-linux-gnu\.tar\.gz$'

    download_release_asset tree-sitter tree-sitter/tree-sitter \
        'tree-sitter-cli-linux-arm64\.zip$' \
        'tree-sitter-linux-arm64\.gz$'

    download_release_asset zoxide ajeetdsouza/zoxide \
        'zoxide-[^/]*-aarch64-unknown-linux-musl\.tar\.gz$' \
        'zoxide-[^/]*-aarch64-unknown-linux-gnu\.tar\.gz$'

    download_release_asset neovim neovim/neovim \
        'nvim-linux-arm64\.tar\.gz$'

    download_release_asset nushell nushell/nushell \
        'nu-[^/]*-aarch64-unknown-linux-musl\.tar\.gz$' \
        'nu-[^/]*-aarch64-unknown-linux-gnu\.tar\.gz$'

    download_release_asset opencode anomalyco/opencode \
        'opencode-linux-arm64-musl\.tar\.gz$' \
        'opencode-linux-arm64\.tar\.gz$'

    download_release_asset deja-vu vshulcz/deja-vu \
        'deja-vu_[^/]*_linux_arm64\.tar\.gz$'

    download_release_asset zellij zellij-org/zellij \
        'zellij-aarch64-unknown-linux-musl\.tar\.gz$'

elif [[ "$OS" == "macos" && "$ARCH" == "x86_64" ]]; then
    download_release_asset bottom ClementTsang/bottom \
        'bottom_x86_64-apple-darwin\.tar\.gz$'

    download_release_asset fd sharkdp/fd \
        'fd-v[^/]*-x86_64-apple-darwin\.tar\.gz$'

    download_release_asset fzf junegunn/fzf \
        'fzf-[^/]*-darwin_amd64\.tar\.gz$'

    download_release_asset ripgrep BurntSushi/ripgrep \
        'ripgrep-[^/]*-x86_64-apple-darwin\.tar\.gz$'

    download_release_asset tree-sitter tree-sitter/tree-sitter \
        'tree-sitter-cli-macos-x64\.zip$' \
        'tree-sitter-macos-x64\.gz$'

    download_release_asset zoxide ajeetdsouza/zoxide \
        'zoxide-[^/]*-x86_64-apple-darwin\.tar\.gz$'

    download_release_asset neovim neovim/neovim \
        'nvim-macos-x86_64\.tar\.gz$'

    download_release_asset nushell nushell/nushell \
        'nu-[^/]*-x86_64-apple-darwin\.tar\.gz$'

    # Explicitly choose the normal x64 build, never *baseline*.
    download_release_asset opencode anomalyco/opencode \
        'opencode-darwin-x64\.zip$'

    download_release_asset deja-vu vshulcz/deja-vu \
        'deja-vu_[^/]*_darwin_amd64\.tar\.gz$'

    download_release_asset zellij zellij-org/zellij \
        'zellij-x86_64-apple-darwin\.tar\.gz$'

elif [[ "$OS" == "macos" && "$ARCH" == "aarch64" ]]; then
    download_release_asset bottom ClementTsang/bottom \
        'bottom_aarch64-apple-darwin\.tar\.gz$'

    download_release_asset fd sharkdp/fd \
        'fd-v[^/]*-aarch64-apple-darwin\.tar\.gz$'

    download_release_asset fzf junegunn/fzf \
        'fzf-[^/]*-darwin_arm64\.tar\.gz$'

    download_release_asset ripgrep BurntSushi/ripgrep \
        'ripgrep-[^/]*-aarch64-apple-darwin\.tar\.gz$'

    download_release_asset tree-sitter tree-sitter/tree-sitter \
        'tree-sitter-cli-macos-arm64\.zip$' \
        'tree-sitter-macos-arm64\.gz$'

    download_release_asset zoxide ajeetdsouza/zoxide \
        'zoxide-[^/]*-aarch64-apple-darwin\.tar\.gz$'

    download_release_asset neovim neovim/neovim \
        'nvim-macos-arm64\.tar\.gz$'

    download_release_asset nushell nushell/nushell \
        'nu-[^/]*-aarch64-apple-darwin\.tar\.gz$'

    download_release_asset opencode anomalyco/opencode \
        'opencode-darwin-arm64\.zip$'

    download_release_asset deja-vu vshulcz/deja-vu \
        'deja-vu_[^/]*_darwin_arm64\.tar\.gz$'

    download_release_asset zellij zellij-org/zellij \
        'zellij-aarch64-apple-darwin\.tar\.gz$'
fi

echo
echo "Summary: OK=${OK}, SKIP=${SKIP}, FAIL=${FAIL}"

if [[ "$FAIL" -gt 0 ]]; then
    exit 1
fi
