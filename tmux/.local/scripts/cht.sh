#!/usr/bin/env bash

languages="bash sh zsh fish c cpp csharp go rust python javascript typescript nodejs java kotlin scala ruby php perl lua haskell elixir erlang ocaml zig swift dart"

selected=$(printf "%s\n" $languages | fzf --layout=reverse --prompt="Language > ")
[ -z "$selected" ] && exit 0

query=$(fzf --print-query --layout=reverse --prompt="Query > " --disabled --no-info < /dev/null | head -1)
[ -z "$query" ] && exit 0

curl -s cht.sh/$selected/$(echo "$query" | tr " " "+") | less -RX
