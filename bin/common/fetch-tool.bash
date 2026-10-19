#!/usr/bin/env bash
# Download the latest prebuilt archives for a small CLI toolset.
# Supported hosts: Linux/macOS on x86_64 or aarch64/arm64.
# Usage:
#   ./fetch-tool.bash <target> [destination]
#   ./fetch-tool.bash --help
#
# Targets: bottom, deja-vu, fd, fzf, neovim, nushell, opencode,
#  ripgrep, tree-sitter, zellij, zoxide
#
# The script only downloads archives; it does not extract or install them.
# Downloader preference: wget, then curl.
#
# OpenCode uses the official V2 download endpoint; other targets use GitHub's
# latest stable release API. Optional GITHUB_TOKEN authenticates API queries
# only, never archive downloads. API redirects are not followed.

set -uo pipefail

usage() {
  printf 'Usage: %s <target> [destination]\n' "$0"
  printf 'Targets: bottom deja-vu fd fzf neovim nushell opencode ripgrep tree-sitter zellij zoxide\n'
  printf 'Optional environment: GITHUB_TOKEN (GitHub API queries only).\n'
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
  bottom|deja-vu|fd|fzf|neovim|nushell|opencode|ripgrep|tree-sitter|zellij|zoxide)
    ;;
  *)
    echo "Error: unsupported target: $TARGET" >&2
    usage >&2
    exit 2
    ;;
esac

DEST_DIR="${2:-.}"
mkdir -p "$DEST_DIR" || exit 1

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

diagnostic() {
  local message="$1"
  if [[ -n "${GITHUB_TOKEN:-}" ]]; then
    message="${message//"$GITHUB_TOKEN"/[REDACTED]}"
  fi
  printf '       %s\n' "${message:0:500}" >&2
}

# Capture response headers even on HTTP errors. Keep API requests separate
# from redirected archive downloads so wget cannot forward an API token.
request_file() (
  local url="$1"
  local path="$2"
  local api="${3:-false}"
  local work status code line value
  local args=(--user-agent 'dotfiles-fetch-tool')

  work="$(mktemp -d "${TMPDIR:-/tmp}/fetch-tool.XXXXXX")" || return 1
  trap 'rm -f "$work/headers" "$work/errors"; rmdir "$work"' EXIT
  : > "$work/headers"
  : > "$work/errors"

  if [[ "$api" == true ]]; then
    [[ "$url" == https://api.github.com/* ]] || return 1
    args+=(--header 'Accept: application/vnd.github+json')
    if [[ -n "${GITHUB_TOKEN:-}" ]]; then
      args+=(--header "Authorization: Bearer $GITHUB_TOKEN")
    fi
  fi

  rm -f -- "$path"
  if [[ "$DOWNLOADER" == "wget" ]]; then
    [[ "$api" != true ]] || args+=(--max-redirect=0)
    wget --no-verbose --server-response --content-on-error "${args[@]}" -O "$path" "$url" 2> "$work/headers"
    code=$?
  else
    if [[ "$api" == true ]]; then
      args+=(--no-location --max-redirs 0)
    else
      args+=(--location)
    fi
    # Do not use --fail: the error response body contains GitHub's message.
    curl --silent --show-error "${args[@]}" --dump-header "$work/headers" -o "$path" "$url" 2> "$work/errors"
    code=$?
  fi

  status="$(awk '/^[[:space:]]*HTTP\// { status=$2 } END { print status }' "$work/headers")"
  if [[ "$code" -eq 0 && "$status" == 2[0-9][0-9] ]]; then
    return 0
  fi

  diagnostic "Request URL: $url"
  diagnostic "Downloader: $DOWNLOADER; exit code: $code; HTTP status: ${status:-unavailable}"
  if [[ "$api" == true ]]; then
    if [[ -f "$path" ]]; then
      line="$(sed -nE 's/.*"message"[[:space:]]*:[[:space:]]*"([^"\\]*).*/\1/p' "$path" | head -n 1)"
      [[ -z "$line" ]] || diagnostic "GitHub message: $line"
    fi
    for line in x-ratelimit-remaining x-ratelimit-reset retry-after; do
      value="$(awk -v key="$line" '
        /^[[:space:]]*HTTP\// { value="" }
        { text=$0; sub(/^[[:space:]]*/, "", text)
          if (index(tolower(text), key ":") == 1) {
            sub(/^[^:]*:[[:space:]]*/, "", text); sub(/\r$/, "", text); value=text
          }
        } END { print value }' "$work/headers")"
      [[ -z "$value" ]] || diagnostic "$line: $value"
    done
    [[ "$status" != 3[0-9][0-9] ]] || diagnostic 'API redirects are disabled to protect GITHUB_TOKEN.'
  fi

  # wget writes response headers and errors to the same stream. Omit header
  # lines and show only a short, redacted tail of transport diagnostics.
  while IFS= read -r line; do
    [[ -z "$line" ]] || diagnostic "$line"
  done < <(if [[ "$DOWNLOADER" == wget ]]; then
    grep -vE '^[[:space:]]' "$work/headers"
  else
    cat "$work/errors"
  fi | tail -n 5)
  return 1
)

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
  local json body code

  body="$(mktemp "${TMPDIR:-/tmp}/fetch-tool-body.XXXXXX")" || return 1
  request_file "https://api.github.com/repos/${repo}/releases/latest" "$body" true
  code=$?
  if [[ "$code" -ne 0 ]]; then
    rm -f "$body"
    return "$code"
  fi
  json="$(cat "$body")"
  rm -f "$body"

  # Keep this bootstrap script dependency-free. Check the expected shape
  # before extracting URLs; an empty assets array is valid, not a query error.
  json="${json//$'\n'/}"
  json="${json//$'\r'/}"
  if ! printf '%s\n' "$json" | grep -qE '"assets"[[:space:]]*:[[:space:]]*\['; then
    diagnostic "Could not parse release metadata: expected an assets array. URL: https://api.github.com/repos/${repo}/releases/latest"
    return 1
  fi
  if printf '%s\n' "$json" | grep -qE '"assets"[[:space:]]*:[[:space:]]*\[[[:space:]]*\]'; then
    return 0
  fi

  printf '%s\n' "$json" \
    | grep -oE '"browser_download_url"[[:space:]]*:[[:space:]]*"[^"]+"' \
    | cut -d '"' -f 4 || {
      diagnostic "Could not parse release metadata: expected asset download URLs. URL: https://api.github.com/repos/${repo}/releases/latest"
      return 1
    }
}

download_release_asset() {
  local name="$1"
  [[ "$name" == "$TARGET" ]] || return 0

  local repo="$2"
  shift 2
  local patterns=("$@")

  local release_url="https://api.github.com/repos/${repo}/releases/latest"
  local pattern url candidate
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

  local selected_urls=()
  for pattern in "${patterns[@]}"; do
    url="$(printf '%s\n' "$urls" | grep -E "$pattern" | head -n 1 || true)"
    [[ -n "$url" ]] || continue
    selected_urls+=("$url")
  done

  if [[ "${#selected_urls[@]}" -eq 0 ]]; then
    echo "[SKIP] $name: no native release asset for ${OS}/${ARCH}"
    echo "       Candidate URL: $release_url"
    SKIP=$((SKIP + 1))
    return
  fi

  download_assets "$name" "${selected_urls[@]}"
}

download_assets() {
  local name="$1"
  shift
  local url filename path

  for url in "$@"; do

    filename="${url##*/}"
    path="${DEST_DIR%/}/$filename"

    echo
    echo "[$name] $filename"
    if ! request_file "$url" "$path"; then
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

  echo "[FAIL] $name: all matching assets failed to download/validate" >&2
  FAIL=$((FAIL + 1))
}

download_opencode() {
  [[ "$TARGET" == opencode ]] || return 0
  local filename
  local urls=()
  for filename in "$@"; do
    urls+=("https://opencode.ai/update/api/latest/cli/opencode/$filename")
  done
  download_assets opencode "${urls[@]}"
}

echo "Detected: ${OS}/${ARCH}"
echo "Downloader: ${DOWNLOADER}"
echo "Destination: ${DEST_DIR}"
echo "Target: ${TARGET}"

if [[ "$OS" == "linux" && "$ARCH" == "x86_64" ]]; then
  download_release_asset bottom ClementTsang/bottom \
    'bottom_x86_64-unknown-linux-musl\.tar\.gz$' \
    'bottom_x86_64-unknown-linux-gnu\.tar\.gz$'

  download_release_asset deja-vu vshulcz/deja-vu \
    'deja-vu_[^/]*_linux_amd64\.tar\.gz$'

  download_release_asset fd sharkdp/fd \
    'fd-v[^/]*-x86_64-unknown-linux-musl\.tar\.gz$' \
    'fd-v[^/]*-x86_64-unknown-linux-gnu\.tar\.gz$'

  download_release_asset fzf junegunn/fzf \
    'fzf-[^/]*-linux_amd64\.tar\.gz$'

  download_release_asset neovim neovim/neovim \
    'nvim-linux-x86_64\.tar\.gz$'

  download_release_asset nushell nushell/nushell \
    'nu-[^/]*-x86_64-unknown-linux-musl\.tar\.gz$' \
    'nu-[^/]*-x86_64-unknown-linux-gnu\.tar\.gz$'

  # Explicitly choose the normal x64 build, never *baseline*.
  download_opencode \
    'opencode-linux-x64-musl.tar.gz' \
    'opencode-linux-x64.tar.gz'

  # Prefer musl. If a published musl archive is malformed, validation
  # automatically falls back to the GNU build.
  download_release_asset ripgrep BurntSushi/ripgrep \
    'ripgrep-[^/]*-x86_64-unknown-linux-musl\.tar\.gz$' \
    'ripgrep-[^/]*-x86_64-unknown-linux-gnu\.tar\.gz$'

  download_release_asset tree-sitter tree-sitter/tree-sitter \
    'tree-sitter-cli-linux-x64\.zip$' \
    'tree-sitter-linux-x64\.gz$'

  download_release_asset zellij zellij-org/zellij \
    'zellij-x86_64-unknown-linux-musl\.tar\.gz$'

  download_release_asset zoxide ajeetdsouza/zoxide \
    'zoxide-[^/]*-x86_64-unknown-linux-musl\.tar\.gz$' \
    'zoxide-[^/]*-x86_64-unknown-linux-gnu\.tar\.gz$'

elif [[ "$OS" == "linux" && "$ARCH" == "aarch64" ]]; then
  download_release_asset bottom ClementTsang/bottom \
    'bottom_aarch64-unknown-linux-musl\.tar\.gz$' \
    'bottom_aarch64-unknown-linux-gnu\.tar\.gz$'

  download_release_asset deja-vu vshulcz/deja-vu \
    'deja-vu_[^/]*_linux_arm64\.tar\.gz$'

  download_release_asset fd sharkdp/fd \
    'fd-v[^/]*-aarch64-unknown-linux-musl\.tar\.gz$' \
    'fd-v[^/]*-aarch64-unknown-linux-gnu\.tar\.gz$'

  download_release_asset fzf junegunn/fzf \
    'fzf-[^/]*-linux_arm64\.tar\.gz$'

  download_release_asset neovim neovim/neovim \
    'nvim-linux-arm64\.tar\.gz$'

  download_release_asset nushell nushell/nushell \
    'nu-[^/]*-aarch64-unknown-linux-musl\.tar\.gz$' \
    'nu-[^/]*-aarch64-unknown-linux-gnu\.tar\.gz$'

  download_opencode \
    'opencode-linux-arm64-musl.tar.gz' \
    'opencode-linux-arm64.tar.gz'

  # ripgrep currently publishes GNU rather than musl for Linux ARM64.
  download_release_asset ripgrep BurntSushi/ripgrep \
    'ripgrep-[^/]*-aarch64-unknown-linux-musl\.tar\.gz$' \
    'ripgrep-[^/]*-aarch64-unknown-linux-gnu\.tar\.gz$'

  download_release_asset tree-sitter tree-sitter/tree-sitter \
    'tree-sitter-cli-linux-arm64\.zip$' \
    'tree-sitter-linux-arm64\.gz$'

  download_release_asset zellij zellij-org/zellij \
    'zellij-aarch64-unknown-linux-musl\.tar\.gz$'

  download_release_asset zoxide ajeetdsouza/zoxide \
    'zoxide-[^/]*-aarch64-unknown-linux-musl\.tar\.gz$' \
    'zoxide-[^/]*-aarch64-unknown-linux-gnu\.tar\.gz$'

elif [[ "$OS" == "macos" && "$ARCH" == "x86_64" ]]; then
  download_release_asset bottom ClementTsang/bottom \
    'bottom_x86_64-apple-darwin\.tar\.gz$'

  download_release_asset deja-vu vshulcz/deja-vu \
    'deja-vu_[^/]*_darwin_amd64\.tar\.gz$'

  download_release_asset fd sharkdp/fd \
    'fd-v[^/]*-x86_64-apple-darwin\.tar\.gz$'

  download_release_asset fzf junegunn/fzf \
    'fzf-[^/]*-darwin_amd64\.tar\.gz$'

  download_release_asset neovim neovim/neovim \
    'nvim-macos-x86_64\.tar\.gz$'

  download_release_asset nushell nushell/nushell \
    'nu-[^/]*-x86_64-apple-darwin\.tar\.gz$'

  # Explicitly choose the normal x64 build, never *baseline*.
  download_opencode 'opencode-darwin-x64.zip'

  download_release_asset ripgrep BurntSushi/ripgrep \
    'ripgrep-[^/]*-x86_64-apple-darwin\.tar\.gz$'

  download_release_asset tree-sitter tree-sitter/tree-sitter \
    'tree-sitter-cli-macos-x64\.zip$' \
    'tree-sitter-macos-x64\.gz$'

  download_release_asset zellij zellij-org/zellij \
    'zellij-x86_64-apple-darwin\.tar\.gz$'

  download_release_asset zoxide ajeetdsouza/zoxide \
    'zoxide-[^/]*-x86_64-apple-darwin\.tar\.gz$'

elif [[ "$OS" == "macos" && "$ARCH" == "aarch64" ]]; then
  download_release_asset bottom ClementTsang/bottom \
    'bottom_aarch64-apple-darwin\.tar\.gz$'

  download_release_asset deja-vu vshulcz/deja-vu \
    'deja-vu_[^/]*_darwin_arm64\.tar\.gz$'

  download_release_asset fd sharkdp/fd \
    'fd-v[^/]*-aarch64-apple-darwin\.tar\.gz$'

  download_release_asset fzf junegunn/fzf \
    'fzf-[^/]*-darwin_arm64\.tar\.gz$'

  download_release_asset neovim neovim/neovim \
    'nvim-macos-arm64\.tar\.gz$'

  download_release_asset nushell nushell/nushell \
    'nu-[^/]*-aarch64-apple-darwin\.tar\.gz$'

  download_opencode 'opencode-darwin-arm64.zip'

  download_release_asset ripgrep BurntSushi/ripgrep \
    'ripgrep-[^/]*-aarch64-apple-darwin\.tar\.gz$'

  download_release_asset tree-sitter tree-sitter/tree-sitter \
    'tree-sitter-cli-macos-arm64\.zip$' \
    'tree-sitter-macos-arm64\.gz$'

  download_release_asset zellij zellij-org/zellij \
    'zellij-aarch64-apple-darwin\.tar\.gz$'

  download_release_asset zoxide ajeetdsouza/zoxide \
    'zoxide-[^/]*-aarch64-apple-darwin\.tar\.gz$'
fi

echo
echo "Summary: OK=${OK}, SKIP=${SKIP}, FAIL=${FAIL}"

if [[ "$FAIL" -gt 0 ]]; then
    exit 1
fi
