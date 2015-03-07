#!/bin/sh
# RubenKelevra 2012-2015 - <ruben@freifunk-nrw.de>
# Lizenz: AGPL 3.0

function _load_storage() {
    #priv: loads saved variables from storage file
    if [ ! -z "$STORAGEIMPORT" ]; then
        return
    elif [ -z "$STORAGEIMPORT" -a -f "$StorageFn" ]; then
        source "$StorageFn"
        STORAGEIMPORT="1"
    else
        echo "Error: No storage-file found."
        exit 1
    fi
}

function check_load_storage() {
    #pub: loads saved variables from storage file, regenerate file if it's deleted
    if [ ! -z "$STORAGEIMPORT" ]; then
        return
    elif [ -z "$STORAGEIMPORT" -a -f "$StorageFn" ]; then
        _load_storage()
    else
        _gen_save_default_storage()
        _load_storage()
    fi
}

function _gen_save_default_storage() {
    unset STORAGEIMPORT
    _gen_all_storage_defaults()
    
    
}

function _gen_all_storage_defaults() {
    #overwrite all vars with defaults
    _genBootID()
    _genUptime()
    _genSoftIRQ()
    _genCPUusage()
}