#!/bin/zsh

TGT=$1
DEBUG=0

unset path_dict
local -A loaded_dict=()

function init_path_dict() {
    #echo '[*] load define...'
    source ~/.easy_go.rc

    loaded_dict+=(${(kv)path_dict})
}

init_path_dict

for tgt_name tgt (${(kv)loaded_dict})
do
    if [[ $DEBUG == 1 ]]; then
        echo $tgt_name '-->' $tgt
    fi
done

if ((!$+loaded_dict[$TGT])); then
    echo '[ERROR] target not defined'
    unset loaded_dict
    return -1
fi

go_target=$loaded_dict[$TGT]
unset loaded_dict

echo '[*] cd' $go_target
cd $go_target
