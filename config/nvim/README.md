My personal Neovim setup, featuring
- [Vim-Airline](https://github.com/vim-airline/vim-airline) with murmur theme
- [Oceanic-material](https://github.com/glepnir/oceanic-material) colorscheme
- Many plugins, integrations and convenient changes

![](screenshot.png)

## Dependencies
- [Neovim](https://github.com/neovim/neovim), vanilla Vim should also work but not tested.
- [vim-plug](https://github.com/junegunn/vim-plug)
- Python3 with [pynvim](https://github.com/neovim/pynvim)
- [Jedi](https://github.com/davidhalter/jedi) install with `pip install jedi`
- [latexmk](http://users.phys.psu.edu/~collins/software/latexmk-jcc) to help build latex doc
- [LanguageTool](http://www.languagetool.org/download/). 
Unzip a package to `~/.local/bin/LanguageTool`, or use the following commands

```bash
wget https://languagetool.org/download/LanguageTool-stable.zip
unzip LanguageTool-stable.zip -d $HOME/.local/bin/
mv $HOME/.local/bin/LanguageTool-* $HOME/.local/bin/LanguageTool
```

## Usage
After resolving for dependencies, install with `install.py`, then run Neovim (some error may pop up, ignore them) and use `:PlugInstall` then `:UpdateRemotePlugins`
to install all plugins.
Beware that there are a lot of new and different settings from default Vim settings, listed below

- Leader key is `<,>`
- NERDTree
    - When the argument passed to `nvim`/`vim` is a directory, NERDTree auto shows up and change the CWD to it
    - Use `<Ctrl-/>` to toggle display
    - CWD of vim follows NERDTree root
- Clipboard / Register
    - Register works with system clipboard
    - `<d>elete` commands no longer push into register
    - Instead, to "cut", use `<m>ove` which supports motion too
- Use tabbed layout for buffers
    - `<Tab><Tab>` to go to next tab
    - `<Shift-Tab><Tab>` to go to previous tab
    - `<Tab><q>` to close tab
    - `<,><Tab><q>` to force close tab
    - `<Tab><t>` to open new tab
- Markdown extensions
    - Auto collapse from headings, use `<z><o>` to expand, `<z><c>` to collape, `<z><a>` to toggle
    - `:MarkdownPreview` and `:MarkdownPreviewStop` to preview in browser
- Language Check
    - `:LanguageToolCheck` to check current buffer, `:LanguageToolClear`to stop
    - `:lopen` to open the location list window, `:lne` to jump to the next error, etc
- Save session (custom command, compatible to NERDTree)
    - `:SS` to save session at CWD as `Session.vim`
    - `:SS <file.vim>` to save session to other path
    - `:source Session.vim` or `vim -S session.vim` to restore session
- Git integration
    - `:Magit` to use prompted git diff, stage, commit tool
    - `<Ctrl-n>`/`<Ctrl-p>` to navigate hunks
    - `<S>` to stage changes
    - `<C><C>` -> write msg -> `<C><C>`/`:w` to commit changes
    - `:Git push` and other commands provided by [vim-fugitive](https://github.com/tpope/vim-fugitive)
- Python LSP by Jedi with [jedi-vim](https://github.com/davidhalter/jedi-vim)
    - Go-to with `<,><g>`
    - Go to definition with `<,><g><d>`
    - Go to assignments with `<,><g><a>`
    - Go to stub with `<,><g><s>`
    - Go to documentation with `<,><g><k>`
    - Go to next usage with `<,><g><n>`
    - Go to refactor with `<,><g><r>`
- IDE-like debugger with [Vimspector](https://github.com/puremourning/vimspector)
    - The init script does not download the debugger backend engine, however, so check their [Supported Language](https://github.com/puremourning/vimspector#supported-languages) section on corresponding adapter and use `:VimspectorInstall` to install it
    - Vimspector only runs with a `.vimspector.json` in Vim's CWD compatible to installed adapters, check `example-*.vimspector.json` for some examples
    - See [Debug Profile Configuration](https://github.com/puremourning/vimspector#debug-profile-configuration) for example config json format
    - Note the config json also respectes C-style comments
    - `<,><d><b>` to toggle **b**reakpoint, `<,><d><B>` to toggle conditional **b**reakpoint
    - `<,><d><g>` to run/continue debugging (**g**o), `<,><d><p>` to **p**ause debugging, `<,><d><r>` to **r**estart debugging, `<,><d><c>` to **c**ancle debugging
    - `<,><d><s>` to **s**tep over, `<,><d><i>` to step **i**nto, `<,><d><o>` to step **o**ut
    - `<,>dt` to run **t**o line at cursor
    - `<,><d><w>` to set **w**aching the var at cursor
    - `<,><d><l>` to **l** at the var
    - `<,><d><e>` to **e**valuate expressions by sending it from the prompt below
- Build task manager with [asynctasks](https://github.com/skywind3000/asynctasks.vim)
    - Task can be configured with a `.tasks` in Vim's CWD, check `example-*.tasks` for some examples
    - `<,><t><g>` -> type in task name to run task
    - `<,><t><q>` to toggle quickfix window
- JSON file folding and only reveal `"` char at current line
- LaTeX build/view helper powered by [vimtex](https://github.com/lervag/vimtex) plugin
- Misc QoL
    - Quick comment/uncomment with `<,><cc>`, `<,><cu>`
    - Behavior of `<;>` and `<;>` swapped for faster command input
    - Search is case incensitive, except for when uppercase is included (`smartcae`)
    - `<Space><Space>`(double tap space) to quick swtich to the next buffer
    - All indentation configured to 4 spaces
    - Line numbers use differential representation relative to the cursor, only in normal mode in the active buffer
    - Autocomplete shows up at the bottom of the word in insert mode. Use `<Tab>` to go through them.
    - Indentation shows a suble guideline, use `<,><i><g>` to toggle it
    - `:Erc` to quickly **e**dit vim**rc**, `:Src` to quickly **s**ource vim**rc**
    - `<,><o>` to open a line without going into insert
