#!/bin/sh
# RubenKelevra 2012-2015 - <ruben@freifunk-nrw.de>
# Lizenz: AGPL 3.0

function calc2f() {
    local calc_string="$1" fractional_digits={"$2":-'2'}
    if [ -z "$calc_string" ] && exit 1
    
    awk "BEGIN {printf \"%.${fractional_digits}f\",$calc_string}"
}