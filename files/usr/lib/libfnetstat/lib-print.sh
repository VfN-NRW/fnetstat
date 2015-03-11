#!/bin/sh
# RubenKelevra 2012-2015 - <ruben@freifunk-nrw.de>
# Lizenz: AGPL 3.0

_print_filename=""

function set_print_to_file() {
    _print_filename="$1"
}

function _check_print_file() {
    if [ -z "$_print_filename" ]; then
        exit 1
    fi
}

function print_stat_header() {
    _check_print_file
    
    json_open > "$_print_filename"
    json_add_str "sys:script" "v0.6b" >> "$_print_filename"
    json_add_str "type"       "stat" >> "$_print_filename"
}

function print_info_header() {
    _check_print_file

    json_open > "$_print_filename"
    json_add_str "sys:script" "v0.6b" >> "$_print_filename"
    json_add_str "type"       "info" >> "$_print_filename"
}

function print_hostname() {
    if [ "$1" == "as json" ]; then
        _check_print_file
        json_add_str "sys:hostname" "$(get_hostname)" >> "$_print_filename"
    else
        get_hostname
    fi
}

fuction print_bootid() {
    checkBootID
    if [ "$1" == "as json" ]; then
        _check_print_file
        json_add_str "sys:boot_id" "$_BootID" >> "$_print_filename"
    else
        echo "$_BootID"
    fi
}
function print_wan_ip4() {
    if [ "$1" == "as json" ]; then
        _check_print_file
        json_add_str "net:wan:ip4" "$(get_wan_ip4)" >> "$_print_filename"
    else
        get_wan_ip4
    fi
}
function print_wan_ip6() {
    if [ "$1" == "as json" ]; then
        _check_print_file
        json_add_str "net:wan:ip6" "$(get_wan_ip6)" >> "$_print_filename"
    else
        get_wan_ip6
    fi
}
function print_pingcheck_wan_ip4() {
    if [ "$1" == "as json" ]; then
        _check_print_file
        json_add_dec "net:wan:ip4:ping" "$(pingcheck_wan_ip4)" >> "$_print_filename"
    else
        pingcheck_wan_ip4
    fi
}
function print_pingcheck_wan_ip6() {
    if [ "$1" == "as json" ]; then
        _check_print_file
        json_add_dec "net:wan:ip6:ping" "$(pingcheck_wan_ip6)" >> "$_print_filename"
    else
        pingcheck_wan_ip6
    fi
}
function print_uptime() {
    if [ "$1" == "as json" ]; then
        _check_print_file
        json_add_dec "sys:uptime" "$(get_uptime)" >> "$_print_filename"
    else
        get_uptime
    fi
}
function print_idletime() {
    if [ "$1" == "as json" ]; then
        _check_print_file
        json_add_dec "sys:idletime" "$(get_idletime)" >> "$_print_filename"
    else
        get_idletime
    fi
}
function print_idletime() {
    if [ "$1" == "as json" ]; then
        _check_print_file
        json_add_str "sys:localtime" "$(get_time)" >> "$_print_filename"
    else
        get_time
    fi
}
function print_meminfo() {
    if [ "$1" == "as json" ]; then
        _check_print_file
        
        json_array_open "sys:memory" >> "$_print_filename"
        json_add_dec "total"     "$(get_memory_total)" >> "$_print_filename"
        json_add_dec "caching"   "$(get_memory_cached)" >> "$_print_filename"
        json_add_dec "buffering" "$(get_memory_buffers)" >> "$_print_filename"
        json_add_dec "free"      "$(get_memory_free)" >> "$_print_filename"
        json_array_close >> "$_print_filename"
    else
        echo "$(get_memory_total), $(get_memory_cached), $(get_memory_buffers), $(get_memory_free)"
    fi
}
function print_processes_running() {
    if [ "$1" == "as json" ]; then
        _check_print_file
        json_add_dec "sys:processes_running" "$(get_running_processes)" >> "$_print_filename"
    else
        get_running_processes
    fi
}
function print_loadavg() {
    if [ "$1" == "as json" ]; then
        _check_print_file
        json_add_dec "sys:loadavg" "$(get_loadavg)" >> "$_print_filename"
    else
        get_loadavg
    fi

}
function print_cpuinfo() {
    
    if [ "$1" == "as json" ]; then
        _check_print_file
        json_list_open "sys:cpu" >> "$_print_filename"
        for cpu_line in gen_cpustats; do
            
            
    else
        gen_cpustats
    fi
}