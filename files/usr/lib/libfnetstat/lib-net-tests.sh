#!/bin/sh
# RubenKelevra 2012-2015 - <ruben@freifunk-nrw.de>
# Lizenz: AGPL 3.0

function pingcheck_wan_ip4() {
    if [ ping -q -I $WAN_BR $PING_TEST_IP4 -c 4 -W 5 >/dev/null 2>&1 ]; then
        echo 1
    else
        echo 0
    fi
}
function pingcheck_wan_ip6() {
    if [ ping6 -q -I $WAN_BR $PING_TEST_IP6 -c 4 -W 5 >/dev/null 2>&1 ]; then
        echo 1
    else
        echo 0
    fi
}