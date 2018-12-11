#!/usr/bin/env bash

function backup_and_link_files() {
    for i in $@;
    do
        if [ $i == $1 ]
        then
            continue
        fi
        test -e $1/$i && echo "backup file: $1/$i => $1/$i~" && mv $1/$i $1/$i~
        echo "link file: $i => $1/$i" && ln -s $PWD/$i $1/$i
    done
}

backup_and_link_files $HOME .vimrc.local .vimrc.local.bundles 
backup_and_link_files $HOME/.config/nvim 'local_init.vim' 'local_bundles.vim'
