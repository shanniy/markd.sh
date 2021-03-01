#!/bin/sh
[ -z "$1" ] && echo "Usage: markd [OPTIONS] [MARKNAME]" && exit 1
markdrc="${XDG_CONFIG_HOME:-$HOME/.config}/markdrc"
dir=$PWD
while getopts ":acdhlp:rv" opt; do
    case ${opt} in
        a ) echo "TODO: All" ; exit 2
            ;;
        c ) C=true
            ;;
        d ) echo "TODO: Delete" ; exit 2
            ;;
        h ) echo "TODO: Help" ; exit 2
            ;;
        l ) L=true
            ;;
        p ) dir=$OPTARG
            ;;
        r ) echo "TODO: Replace" ; exit 2
            ;;
        v ) V=true
            ;;
        \? ) echo "Invalid option"
            ;;
        : ) echo "Option" $OPTARG "expects argument"
    esac
done
shift $((OPTIND -1))
[ -z "$1" ] && echo "Usage: markd [OPTIONS] [MARKNAME]" && exit 1
[ -n "$2" ] && echo "Usage: markd [markname] (optional)[path]" && echo $2 && exit 1

tab='    '
str="cd-$1=\"cd $dir"
[ $C ] && str="${str} && clear"
[ $L ] && str="${str} && ls"
[ $V ] && echo "${str}\" added as an alias"
str="${str}\" \\"

echo "${tab}${str}" >> $markdrc

exec zsh
