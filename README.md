# 💤  LazyVisCode

**LazyVisCode** is a **LazyVim** preset, aims to reproduce VSCode coding style
in NeoVim, while keeps vim style as possible.

## Implemented Features

### Keybindings

- Shift selection, plus `C-c` `C-x` `C-v` copy/paste, plus in place delete/modify,
  without leaving *INSERT* mode. (selection via *SELECT* mode, supports
  `↑↓←→<Home><End>`)
  - It also changes mouse drag select mode to *SELECT* (instead of default *VISUAL*)
- VSCode editing keybindings:
  - Move/copy lines via `A-↑/↓` / `A-S-↑/↓` (*SELECT* mode not supported yet)
  - Save file via `C-s`
  - Delete lines via `C-S-k` (not used by me actually)
  - Undo/Redo via `C-z`/(`C-S-z` or `C-y`)
- VSCode LSP keybindings:
  - Rename symbol via `<F2>`
  - Comment line/lines via `C-/` `C-_` `A-/` [^1]
- VSCode style Tab auto-suggest (via *blink.cmp*)
  - Use `↑/↓` to change suggestions, without auto-accept that
  - Use `Tab`/`Enter` to manually accept (accept first one in default)
  - `ESC` to cancel auto-suggest, without exiting *INSERT* mode.

> [^1]:
> `C-/` does not works on my machines, since my terminal does not send any of
> keybindings with `/.,';`, only with `Alt` is available, but `A-/` is
> *reversed search* in vim... So, `A-/` is only available in *INSERT* and
> *SELECT* mode to toggle comments, as a fallback method.
>
> `C-_` is a fallback of `C-/`, AI told me that many terminal send `C-/` as `C-_`.
>
> Actually, if you really type `C--`, you may find out that modifies your
> terminal font size but not sending any keybindings, so that, `C-_` can only be
> triggered by `C-S-_`.

### Displays

**LazyVisCode uses *neo-tree* instead of *snacks.explorer***, provides better user
experience (in my own word), also provides additional *Opened Buffers(Tabs)*,
*Git*, *Symbols* tabs.

**Opening buffers header (provided by *bufferline*) now will always show,** even
only one uffer is opened. Since nvim does not allow one window area has no
buffer, an New File* buffer will be opened when last buffer is closed.

**Use absolute line number in default** (LazyVim use relative number).

### Behaviors

#### Cwd (current working directory)

**When opening a directory that should be a project, nvim's cwd will switch to
project irectory**, instead of the shell's pwd(default behavior of nvim)
(powered by *project.nvim*).

Shipped with common project identifier patterns, with additional lsp project
dir source support (lsp may be lazy loaded, cannot identify in time), covers
following languages:

- **Version Manager**: `.git` `.svn` `..hg` etc...
- **nvim config home**: `lua`
- **C/C++**: `Makefile` `CMakeList.txt`
- **Java/Kotlin/Scala** etc.
- **C#/MS Basic** (vc++?): `*.sln` `*.csproj`
- **NodeJS**
- **Python**: `requirements.txt` `pyproject.toml`
- **Rust**, **Go**, **PHP**
- **Flutter/Dart**: `pubspec.yaml`

#### Mode auto-switch

**Different windows now have its own editing mode, switching to another window will
recovery their editing mode, or use *NORMAL* as default, instead of keep global
editing mode.** This is implemented by a custom mini plugin *plugin-pre-window-mode*.

It makes you can switch to file tree window while editing file using *INSERT* mode
(no matter using hotkeys or mouses), that file tree window will use default *NORMAL*
mode, makes editor's *INSERT* mode not affecting using file tree. When switch to
file editor back, that *INSERT* mode will be automatically recovered.

#### Misc editor features

**Auto-format have disabled.**

## Contributing

PR/issue welcome if any of VSCode features you want are not implemented, or any
of implementations can be optimized.

