```
 File              : README.md
 Date              : 27.08.2021
 Last Modified Date: 27.08.2021
```
```
 File              : README.md
 Date              : 27.08.2021
 Last Modified Date: 27.08.2021
```
`./install.sh` to install fonts for user

To check installation, try

```bash
fc-match "MesloLGS NF"
fc-match "Noto Sans"
fc-match "Noto Mono"
fc-match "Noto Sans CJK JP"
fc-match "Ubuntu"
fc-match "siji"
```
Some systems reportedly not recognizes Siji as seen in [this issue](https://github.com/stark/siji/issues/28).
Some said use 
```bash
sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf
```
resolved the issue.

As `fonts` subdir includes sources of various fonts, those licensed differently from MIT has their license document attached with them, in the format of `LICENSE-<font-family>`.
