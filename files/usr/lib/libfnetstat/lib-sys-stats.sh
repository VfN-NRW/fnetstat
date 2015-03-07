#!/bin/sh
# RubenKelevra 2012-2015 - <ruben@freifunk-nrw.de>
# Lizenz: AGPL 3.0

function get_hostname() {
    cat /proc/sys/kernel/hostname
}
function get_uptime() {
    cat /proc/uptime | awk '{ print $1 }'
}
function get_idletime() {
    cat /proc/uptime | awk '{ print $2 }'
}
function get_time() {
    date -Iseconds
}
function get_memory_total() {
    cat /proc/meminfo | grep -m 1 'MemTotal' | awk '{ print $2 }'
}
function get_memory_cached() {
    cat /proc/meminfo | grep -m 1 'Cached:' | awk '{ print $2 }'
}    
function get_memory_buffers() {
    cat /proc/meminfo | grep -m 1 'Buffers:' | awk '{ print $2 }'
}
function get_memory_free() {
    cat /proc/meminfo | grep -m 1 'MemFree:' | awk '{ print $2 }'
}
function get_running_processes() {
    echo "$_stat_from_start" | grep -m 1 '^procs_running' | awk '{ print $2 }' 
}
function get_loadavg() {
    echo "$_loadavg_from_start" | awk '{ print $1 }'
}
function gen_cpustats() {
    local _old=$(echo $_stat_from_lasttime | grep ^cpu | grep -v "^cpu " | tr ' ' '=')
    local _new=$(echo $_stat_from_start | grep ^cpu | grep -v "^cpu " | tr ' ' '=')
    
    local _user="" _nice="" _system="" _idle="" _iowait="" _irq="" _sirq="" _   cpu="" total=""
    
    for cpu_line in $old; do        
        _cpu=$(echo $cpu_line | cut -d '=' -f 1)
        
        _user=$(  expr $(echo $_new | grep "$_cpu" | cut -d '=' -f 2) - $(echo $cpu_line | cut -d '=' -f 2))
        _nice=$(  expr $(echo $_new | grep "$_cpu" | cut -d '=' -f 3) - $(echo $cpu_line | cut -d '=' -f 3))
        _system=$(expr $(echo $_new | grep "$_cpu" | cut -d '=' -f 4) - $(echo $cpu_line | cut -d '=' -f 4))
        _idle=$(  expr $(echo $_new | grep "$_cpu" | cut -d '=' -f 5) - $(echo $cpu_line | cut -d '=' -f 5))
        _iowait=$(expr $(echo $_new | grep "$_cpu" | cut -d '=' -f 6) - $(echo $cpu_line | cut -d '=' -f 6))
        _irq=$(   expr $(echo $_new | grep "$_cpu" | cut -d '=' -f 7) - $(echo $cpu_line | cut -d '=' -f 7))
        _sirq=$(  expr $(echo $_new | grep "$_cpu" | cut -d '=' -f 8) - $(echo $cpu_line | cut -d '=' -f 8))
        
        _total=$(expr $_user + $_nice + $_system + $_idle + $_iowait + $_irq + $_sirq)
        
        _user=$(  calc2f "$_user/($_total/100)" )
        _nice=$(  calc2f "$_nice/($_total/100)" )
        _system=$(calc2f "$_system/($_total/100)" )
        _idle=$(  calc2f "$_idle/($_total/100)" )
        _iowait=$(calc2f "$_iowait/($_total/100)" )
        _irq=$(   calc2f "$_irq/($_total/100)" )
        _sirq=$(  calc2f "$_sirq/($_total/100)" )
        
        echo "$_cpu=$_user=$_nice=$_system=$_idle=$_iowait=$_irq=$_sirq"
    done
}
    
for entry in $cpuusage1; do
    if [ "$b" -eq "1" ]; then
        echo ","
    else
        b="1"
    fi

    echo -en "  {"
    cpu=$(echo $entry | cut -d '=' -f 1)
    echo " \"cpu\": \"$cpu\","

    user=$(expr $(echo $cpuusage2 | grep "$cpu" | cut -d '=' -f 2) - $(echo $entry | cut -d '=' -f 2))
    nice=$(expr $(echo $cpuusage2 | grep "$cpu" | cut -d '=' -f 3) - $(echo $entry | cut -d '=' -f 3))
    system=$(expr $(echo $cpuusage2 | grep "$cpu" | cut -d '=' -f 4) - $(echo $entry | cut -d '=' -f 4))
    idle=$(expr $(echo $cpuusage2 | grep "$cpu" | cut -d '=' -f 5) - $(echo $entry | cut -d '=' -f 5))
    iowait=$(expr $(echo $cpuusage2 | grep "$cpu" | cut -d '=' -f 6) - $(echo $entry | cut -d '=' -f 6))
    irq=$(expr $(echo $cpuusage2 | grep "$cpu" | cut -d '=' -f 7) - $(echo $entry | cut -d '=' -f 7))
    sirq=$(expr $(echo $cpuusage2 | grep "$cpu" | cut -d '=' -f 8) - $(echo $entry | cut -d '=' -f 8))
    
    total=$(expr $user + $nice + $system + $idle + $iowait + $irq + $sirq)
    
    user=$(awk "BEGIN {printf \"%.2f\",$user/($total/100)}")
    nice=$(awk "BEGIN {printf \"%.2f\",$nice/($total/100)}")
    system=$(awk "BEGIN {printf \"%.2f\",$system/($total/100)}")
    idle=$(awk "BEGIN {printf \"%.2f\",$idle/($total/100)}")
    iowait=$(awk "BEGIN {printf \"%.2f\",$iowait/($total/100)}")
    irq=$(awk "BEGIN {printf \"%.2f\",$irq/($total/100)}")
    sirq=$(awk "BEGIN {printf \"%.2f\",$sirq/($total/100)}")
    
    echo "    \"user\": $user,"
    echo "    \"nice\": $nice,"
    echo "    \"system\": $system,"
    echo "    \"idle\": $idle,"
    echo "    \"iowait\": $iowait,"
    echo "    \"irq\": $irq,"
    echo "    \"sirq\": $sirq"
    
    echo -en "  }"
done



if [ $b -eq "1" ]; then
    echo ""
fi

echo "  ],"
unset cpu user nice system idle iowait irq sirq OLDIFS b


