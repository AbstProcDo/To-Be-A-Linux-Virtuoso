#!/usr/bin/env zsh
set -euo pipefail

find . -type f -exec grep --color -nH --null -e  \{\} +
