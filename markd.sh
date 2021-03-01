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
        h ) H=true
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
[ $H ] && echo "Usage: markd [OPTIONS] [MARKNAME]" &&
    echo "[MARKNAME] is whatever character sequence you want to use for the alias" &&
    echo "e.g. [MARKNAME] = test, will result in the alias 'cd-test'" &&
    echo "[OPTIONS]:" && echo "-c : will add clear to the alias" &&
    echo "-l : will add ls to the alias (after clear if -c is used)" &&
    echo "-p [PATH] : specify which directory to mark, default is current working directory" &&
    echo "-v : will output the alias that is created" &&
    echo "Other options to be added"
tab='    '
str="cd-$1=\"cd $dir"
[ $C ] && str="${str} && clear"
[ $L ] && str="${str} && ls"
[ $V ] && echo "${str}\" added as an alias"
str="${str}\" \\"

echo "${tab}${str}" >> $markdrc

exec zsh
