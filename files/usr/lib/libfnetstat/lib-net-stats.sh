#!/bin/sh
# RubenKelevra 2012-2015 - <ruben@freifunk-nrw.de>
# Lizenz: AGPL 3.0

function get_wan_ip4() {
    #old
    #echo $(ifconfig $WAN_BR | grep 'inet addr' | awk '{ print $2}' | sed -e 's/addr://g')
    ip addr show dev "$WAN_BR" | grep "inet " | cut -d ' ' -f 6 
}
function get_wan_ip6() {
    #old
    #output=`ifconfig $WAN_BR | grep Scope:Global | awk '{ print $3 }' | sed -e 's/\/64//g'`
    ip addr show dev "$WAN_BR" | grep "inet6 " | grep "scope global" | cut -d ' ' -f 6
}