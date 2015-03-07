#!/bin/sh
# RubenKelevra 2012-2015 - <ruben@freifunk-nrw.de>
# Lizenz: AGPL 3.0

function print_stat_header() {
    json_open
    json_add_str "sys:script" "v0.6b"
    json_add_str "type"       "stat"
}

function print_info_header() {
    json_open
    json_add_str "sys:script" "v0.6b"
    json_add_str "type"       "info"
}

function print_hostname() {
    if [ "$1" == "as json" ]; then
        json_add_str "sys:hostname" "$(get_hostname)"
    else
        get_hostname
    fi
}

fuction print_bootid() {
    checkBootID
    if [ "$1" == "as json" ]; then
        json_add_str "sys:boot_id" "$_BootID"
    else
        echo "$_BootID"
    fi
}
function print_wan_ip4() {
    if [ "$1" == "as json" ]; then
        json_add_str "net:wan:ip4" "$(get_wan_ip4)"
    else
        get_wan_ip4
    fi
}
function print_wan_ip6() {
    if [ "$1" == "as json" ]; then
        json_add_str "net:wan:ip6" "$(get_wan_ip6)"
    else
        get_wan_ip6
    fi
}
function print_pingcheck_wan_ip4() {
    if [ "$1" == "as json" ]; then
        json_add_dec "net:wan:ip4:ping" "$(pingcheck_wan_ip4)"
    else
        pingcheck_wan_ip4
    fi
}
function print_pingcheck_wan_ip6() {
    if [ "$1" == "as json" ]; then
        json_add_dec "net:wan:ip6:ping" "$(pingcheck_wan_ip6)"
    else
        pingcheck_wan_ip6
    fi
}
function print_uptime() {
    if [ "$1" == "as json" ]; then
        json_add_dec "sys:uptime" "$(get_uptime)"
    else
        get_uptime
    fi
}
function print_idletime() {
    if [ "$1" == "as json" ]; then
        json_add_dec "sys:idletime" "$(get_idletime)"
    else
        get_idletime
    fi
}
function print_idletime() {
    if [ "$1" == "as json" ]; then
        json_add_str "sys:localtime" "$(get_time)"
    else
        get_time
    fi
}
function print_meminfo() {
    if [ "$1" == "as json" ]; then
        json_array_open "sys:memory"
        json_add_dec "total"     "$(get_memory_total)"
        json_add_dec "caching"   "$(get_memory_cached)"
        json_add_dec "buffering" "$(get_memory_buffers)"
        json_add_dec "free"      "$(get_memory_free)"
        json_array_close
    else
        echo "$(get_memory_total), $(get_memory_cached), $(get_memory_buffers), $(get_memory_free)"
    fi
}
function print_processes_running() {
    if [ "$1" == "as json" ]; then
        json_add_dec "sys:processes_running" "$(get_running_processes)"
    else
        get_running_processes
    fi
}
function print_loadavg() {
    if [ "$1" == "as json" ]; then
        json_add_dec "sys:loadavg" "$(get_loadavg)"
    else
        get_loadavg
    fi

}
function print_cpuinfo() {
    
    if [ "$1" == "as json" ]; then
        json_list_open "sys:cpu"
        for cpu_line in gen_cpustats; do
            
            
    else
        gen_cpustats
    fi
}