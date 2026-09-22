# Third-Party Notices

This file is an index of identified third-party material included in this
repository. Original files are distributed under the license in
[`LICENSE`](LICENSE); the components below remain subject to their own
copyright and license terms.

## Bundled Binaries

| Component | License |
| --- | --- |
| [bottom](https://github.com/ClementTsang/bottom) | MIT               |
| [fast](https://github.com/neur1n/fast)           | MulanPSL-2.0      |
| [fd](https://github.com/sharkdp/fd)              | MIT or Apache-2.0 |
| [fzf](https://github.com/junegunn/fzf)           | MIT               |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | MIT or Unlicense  |
| [vswhere](https://github.com/microsoft/vswhere)  | MIT               |
| [zoxide](https://github.com/ajeetdsouza/zoxide)  | MIT               |

These entries cover the corresponding tools included under `bin/`. The
`fast` project also supplies the matching shell wrappers in `bin/common/fast/`.

## Neovim LSP Files

The following files are copied or adapted from the
[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) project, which is
licensed under the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0):

```text
neovim/lsp/basedpyright.lua
neovim/lsp/clangd.lua
neovim/lsp/lua_ls.lua
neovim/lsp/nushell.lua
neovim/lsp/texlab.lua
```

The exact upstream revision is not recorded in this repository. Retain the
Apache-2.0 license and any copyright notices from the corresponding upstream
revision when distributing these files.

## Spell Data

The compiled Vim spell files are included at:

```text
neovim/spell/en.utf-8.spl
neovim/spell/en.utf-8.sug
```

These are compiled Vim runtime spell data. Relevant Vim documentation and
source locations are:

- [Vim spell data README](https://github.com/vim/vim/blob/master/runtime/spell/README.txt)
- [Vim spell data server](https://ftp.nluug.nl/pub/vim/runtime/spell/)

The exact Vim runtime revision is not recorded in this repository. Consult the
upstream Vim documentation for the applicable provenance and notices when
redistributing these files.

## Palette Data

`neovim/lua/palette.lua` contains original and derived palette groups. The
links below identify related projects; they do not relicense those projects.

| Palette | License |
| --- | --- |
| clack                                                            | Original   |
| [github](https://github.com/projekt0n/github-nvim-theme)         | MIT        |
| [iceberg](https://github.com/cocopon/iceberg.vim)                | MIT        |
| [neovim](https://github.com/neovim/neovim)                       | Apache-2.0 |
| [nightfox](https://github.com/EdenEast/nightfox.nvim)            | MIT        |
| [poimandres](https://github.com/drcmda/poimandres-theme)         | MIT        |
| [synthwave-vscode](https://github.com/robb0wen/synthwave-vscode) | MIT        |

## Fonts

The archive `font/font.tar.xz` contains a selected set of patched fonts from
the [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts). It is a
repository-specific repackaging, not the complete upstream release archive.
Nerd Fonts aggregates fonts with different upstream notices. Preserve the
license and README files in the archive's individual font directories when
extracting or redistributing the fonts; those notices take precedence over
this summary.

## Runtime Dependencies Not Vendored

The Neovim plugin declarations in
[`neovim/lua/plugconf/lazy.lua`](neovim/lua/plugconf/lazy.lua) reference
external projects, including `lazy.nvim` and the plugins listed in that file.
Their source code is downloaded into Neovim's data directory at runtime and is
not vendored in this repository. Each project retains its own license.

The `fetch-tool` scripts can also download release archives from upstream
projects. Those downloads are outside this manifest and retain their own
licenses.

## License Texts

This file is an attribution index, not a replacement for third-party license
texts. A redistribution that includes the binaries, fonts, or copied files
above must retain the corresponding upstream license texts and copyright
notices as required by each license. The root [`LICENSE`](LICENSE) applies to
original repository content only.
