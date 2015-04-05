#!/bin/sh
# RubenKelevra 2012-2015 - <ruben@freifunk-nrw.de>
# Lizenz: AGPL 3.0

function gen_cur_stat_fn() {
    echo "$WorkFolder/fnestat-statfile-$(get_time).json"
}