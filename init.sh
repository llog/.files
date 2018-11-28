#!/usr/bin/env bash

PWD=$(pwd)

echo "link .files/* => ~ ..."

for i in $(ls -A -I init.sh -I .git);
do
    test -e ~/$i && echo "backup original file $i => $i~" && mv ~/$i ~/$i~
    echo "link $PWD/$i => ~/$i"
    ln -s $PWD/$i ~
done
