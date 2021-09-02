My personal zsh configuration.

## Related Packages/Programs
Core
- [zsh](https://www.zsh.org/) duh

Supported and alias-related tools
- [conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html) Python environment manager
- [exa](https://github.com/ogham/exa) configurable `ls` with more features
- [latexmk](https://latextools.readthedocs.io/en/latest/install/#linux) LaTeX build tools
- [howdoi](https://github.com/gleitz/howdoi) quick web search
- [translate-shell](https://github.com/soimort/translate-shell) quick cli Google translate
- [WordNet](https://wordnet.princeton.edu/download/current-version#nix), may also available with packages, english language engine to find synonyms
- Some powerline symbol fonts, can be installed from `scripts/fonts-install`

After resolving dependencies, use `chsh -s $(which zsh)` to set default shell.
Then use `install.py` to install config.
