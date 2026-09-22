<pre align="center">
█▀▀▀▀▀▀██▀▀▀▀▀▀▀█▀▀▀▀▀▀▀█▀▀▀▀▀▀▀█▀▀▀▀▀▀▀█▀▀▀█████▀▀▀▀▀▀▀█▀▀▀▀▀▀▀█
█   ▄   █   ▄   █▄▄   ▄▄█   ▄▄▄▄█▄▄   ▄▄█   █████   ▄▄▄▄█   ▄▄▄▄█
█   █   █   █   ███   ███       ███   ███   █████       █       █
█   ▀   █   ▀   ███   ███   █████▀▀   ▀▀█   ▀▀▀▀█   ▀▀▀▀█▀▀▀▀   █
█▄▄▄▄▄▄██▄▄▄▄▄▄▄███▄▄▄███▄▄▄█████▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█
</pre>

<p align="center">
  or whatchamacallit
</p>

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Deployment](#deployment)
- [Terminal Configuration](#terminal-configuration)
- [Tool Fetching](#tool-fetching)
- [Third-Party Notices](#third-party-notices)
- [License](#license)

## Overview

<pre>
dotfiles/
├─ bin/                       Platform-specific tools
├─ deploy/                    Cross-platform deployment scripts
├─ font/                      Bundled font archive and alphabet artwork
├─ komorebi/                  Komorebi and WHKD configuration
├─ neovim/                    Neovim configuration
├─ nushell/                   Nushell configuration and modules
├─ opencode/                  OpenCode configuration, instructions, and skills
│  └─ skills/
│     ├─ phased-development/  Phased development workflow
│     └─ read-paper/          Academic paper analysis workflow
├─ selecton/                  Selecton configuration
├─ terminal/                  Terminal configuration sources and generators
│  ├─ ghostty/                Ghostty configuration generator
│  └─ wt/                     Windows Terminal settings generator
├─ wezterm/                   WezTerm configuration
└─ zellij/                    Zellij configuration
</pre>

## Requirements

- Git for:
    - cloning the repository
    - bootstrapping `lazy.nvim`
    - using the `phased-development` skill.
- Bash on Linux or macOS, or PowerShell on Windows.
- `jq` when running `terminal/ghostty/ghostty.bash`.
- `wget` or `curl` for `fetch-tool.bash/ps1`.

## Installation

Clone the repository and enter its root directory:

```sh
git clone https://github.com/neur1n/dotfiles.git
cd dotfiles
```

## Deployment

Deployment uses symbolic links on Linux and macOS. On Windows, directory
profiles use junctions and file profiles use symbolic links.

```sh
# Linux and macOS
./deploy/deploy.bash <profile> [--dry-run] [--open]
```

```powershell
# Windows
.\deploy\deploy.ps1 <profile> [--dry-run] [--open]
```

The deployers support the following profiles:

1. `claude`
2. `codex`
3. `komorebi` (Windows only)
4. `neovim`
5. `nushell`
6. `opencode`
7. `wezterm`
8. `zellij`

`--dry-run` previews the directories and links without changing the system.
`--open` asks the platform's default GUI handler to open the deployment target;
it is skipped in remote sessions or when no GUI session is available.

The deployers create links rather than copying configuration files. They refuse
to replace an existing destination that does not point to the expected source,
and they do not create backups.

The main profile destinations are:

| Profile | Unix | Windows |
| --- | --- | --- |
| `claude`   | Existing `~/.claude`                                                 | Existing `%USERPROFILE%\.claude`                          |
| `codex`    | Existing `~/.codex`                                                  | Existing `%USERPROFILE%\.codex`                           |
| `komorebi` | Not Available                                                        | `%USERPROFILE%` and `%USERPROFILE%\.config`               |
| `neovim`   | `~/.config/nvim`                                                     | `%LOCALAPPDATA%\nvim`                                     |
| `nushell`  | `~/.config/nushell` or macOS `~/Library/Application Support/nushell` | `%APPDATA%\nushell`                                       |
| `opencode` | `~/.config/opencode`                                                 | `%USERPROFILE%\.config\opencode`                          |
| `wezterm`  | `~/.wezterm.lua` and `~/.wezterm`                                    | `%USERPROFILE%\.wezterm.lua` and `%USERPROFILE%\.wezterm` |
| `zellij`   | `~/.config/zellij`                                                   | `%APPDATA%\Zellij\config`                                 |

The `claude` and `codex` profiles require their documented configuration
directories to already exist. The Windows deployer also requires the relevant
standard environment variables such as `USERPROFILE`, `APPDATA`, or
`LOCALAPPDATA`.

## Terminal Configuration

The terminal scripts combine a base configuration with shared font, color
scheme, and theme data. They select available fonts and schemes, and Windows
Terminal themes, at random when generating a configuration.

Generate a Ghostty configuration on Linux or macOS:

```sh
./terminal/ghostty/ghostty.bash
```

It writes to `$XDG_CONFIG_HOME/ghostty/config.ghostty` when
`XDG_CONFIG_HOME` is an absolute path, otherwise to
`~/.config/ghostty/config.ghostty`.

Generate Ghostty or Windows Terminal settings on Windows:

```powershell
.\terminal\ghostty\ghostty.ps1
.\terminal\wt\wt.ps1
```

The Windows scripts write to `%LOCALAPPDATA%\ghostty\config.ghostty` and
`%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`,
respectively.

## Tool Fetching

The fetch helpers download the latest matching release archive for a target;
they do not extract or install it.

```sh
# Linux or macOS
./bin/common/fetch-tool.bash <target> [destination]
```

```powershell
# Windows
.\bin\common\fetch-tool.ps1 <target> [destination]
```

Available targets are:
1. `bottom`
2. `deja-vu`
3. `fd`
4. `fzf`
5. `neovim`
6. `nushell`
7.  `opencode`
8. `ripgrep`
9. `tree-sitter`
10. `zellij`
11. `zoxide`

The Bash helper supports Linux and macOS on x86_64 or aarch64/arm64; the
PowerShell helper supports Windows x86_64 and ARM64.

## Third-Party Notices

Bundled binaries, copied configuration fragments, generated spell data, font
files, and derived color palettes may have licenses independent of this
repository. See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for their
sources and license information.

## License

Distributed under the [MulanPSL-2.0](http://license.coscl.org.cn/MulanPSL2) license. See [LICENSE](LICENSE) for details.

<details>
  <summary>Why MulanPSL-2.0?</summary>

The Mulan Permissive Software License v2 (MulanPSL-2.0) may be less familiar than more widely used licenses. To provide clarity and context, the following table (cited from [*Choose a License*](https://choosealicense.com/appendix/)) compares key aspects of MulanPSL v2 with popular licenses including *Apache-2.0*, *BSD-3-Clause*, and *MIT*.

| License          | Commercial Use | Distribution | Modification | Patent Use | Private Use | Disclose Source | License and Copyright Notice | Network Use is Distribution | Same License | State Changes | Liability | Trademark Use | Warranty |
|:----------------:|:--------------:|:------------:|:-------------:|:----------:|:-----------:|:---------------:|:----------------------------:|:---------------------------:|:------------:|:-------------:|:---------:|:-------------:|:--------:|
| Apache-2.0       | 🟢             | 🟢           | 🟢           | 🟢         | 🟢          |                 | 🔵                           |                             |              | 🔵            | 🔴        | 🔴            | 🔴       |
| BSD-3-Clause     | 🟢             | 🟢           | 🟢           |            | 🟢          |                 | 🔵                           |                             |              |               | 🔴        |               | 🔴       |
| MIT              | 🟢             | 🟢           | 🟢           |            | 🟢          |                 | 🔵                           |                             |              |               | 🔴        |               | 🔴       |
| MulanPSL-2.0     | 🟢             | 🟢           | 🟢           | 🟢         | 🟢          |                 | 🔵                           |                             |              |               | 🔴        | 🔴            | 🔴       |

The drafter of the MulanPSL-2.0 license addressed similar concerns in this [comment](https://github.com/originjs/vite-plugin-federation/issues/464#issuecomment-1774859600):

> Thank you for raising this issue. Please allow me to explain. (I'm the one responsible for drafting MulanPSL-2.0 and getting it approved by OSI.)
>
> Actually at the beginning we just say in the license, english and chinese version have the same legal effect (because we carefully translated the two versions word by word, sentence by sentence). However, the OSI community suggested that IN CASE, in case there is a conflict between the two languages, we should indicate which language prevails.
>
> However, I must say, there is a tiny chance (close to zero) that this circumstance will happen. On the one hand, many people (including technical experts and lawyers) did careful proofreading between english version and chinese version; on the other hand, MulanPSL-2.0 is such a loose license that really doesn't have constrains, what conflict will you expect? We worry about conflict because we worry about legal risk that may bring, but since the legal terms are so loose we hardly see a risk.
</details>
