#!/bin/sh
# RubenKelevra 2012-2015 - <ruben@freifunk-nrw.de>
# Lizenz: AGPL 3.0

LINEENDPRINTED=-1
ARRAYOPEN=-1
LISTOPEN=-1
FIRSTLISTELEMENT=-1

### Root functions ###
function json_open() {
    echo "{"
    LINEENDPRINTED=1
}
function json_close() {
    [ $LINEENDPRINTED -eq 0 ] && echo ""
    echo "}"
    LINEENDPRINTED=1
}

function _json_next_element() {
    [ $LINEENDPRINTED -eq 0 ] && echo ","
    LINEENDPRINTED=1
}
function _json_do_indent() {
    [ $ARRAYOPEN -eq 1 ] && echo -ne "  "
}

### Single functions ###
function json_add_str() {
    local key="$1" value="$2"
    _json_next_element
    _json_do_indent
    echo -ne "\"$key\": \"$value\""
    LINEENDPRINTED=0
}
function json_add_dec() {
    local key="$1" value="$2"
    _json_next_element
    _json_do_indent
    echo -ne "\"$key\": $value"
    LINEENDPRINTED=0
}

### Array functions ###
function json_array_open() {
    local array_key="$1"
    _json_next_element
    echo "\"$array_key\": {" 
    ARRAYOPEN=1
    LINEENDPRINTED=1
}
function json_array_close() {
    [ $LINEENDPRINTED -eq 0 ] && echo ""
    echo -ne "  }"
    ARRAYOPEN=0
    LINEENDPRINTED=0
}

### List functions ###
function json_list_open() {
    local list_key="$1"
    _json_next_element
    echo "\"$list_key\": ["
    LISTOPEN=1
    LINEENDPRINTED=1
    FIRSTLISTELEMENT=1
}
function json_add_list_str_item() {

}
function json_add_list_dec_item() {

}
function json_list_next_element() {

}
function json_list_close() {

}
