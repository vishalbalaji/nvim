# Neovim
Configs for neovim

- Install Vim-Plug
  * `sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'`
- Add this to `~/.config/coc/ultisnips/sh.snippets`
 
```sh
snippet #! "sh shebang" bA
#!/usr/bin/env sh

$1
endsnippet
```

- Add this to `~/.config/coc/ultisnips/vimwiki.snippets`
 
```sh
snippet #! "Markdown yaml for SRM documents" bA
---
title: $1
author: |
	| __Vishal Balaji D__
	| \small RA1711003040039
	| \small CSE - 'A'(4th year)
classoption: a4paper
numbersections: true
geometry: margin=0.75in
<!--theme: Berkeley-->
---

$2
endsnippet
```
