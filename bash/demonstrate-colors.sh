#!/usr/bin/env bash
#
# https://wiki.archlinux.org/index.php/Bash/Prompt_customization

reset()
{
    echo -en "\e[0m"
}

echo "=== standard colors"
for C in {40..47}; do
    echo -en "\e[${C}m$C "
    reset
done
echo

echo "=== high intensity colors"
for C in {100..107}; do
    echo -en "\e[${C}m$C "
    reset
done
echo

echo "=== 256 colors"
for C in {16..255}; do
    echo -en "\e[48;5;${C}m$C "
    reset
done
echo -e "\e(B\e[m"
echo

