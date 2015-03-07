#!/bin/sh
# RubenKelevra 2012-2015 - <ruben@freifunk-nrw.de>
# Lizenz: AGPL 3.0

function checkBootID() {
    [ -z $_BootID ] &&  _genbootid()
}
function _genBootID() {
    _BootID=$(head -1 /dev/urandom | md5sum | awk '{ print $1 }')
}

function checkUptime() {
    [ -z $_Uptime ] && _genUptime()
}
function _genUptime() {
    _Uptime=0
}

function checkSoftIRQ() {
    [ -z $_SoftIRQ ] && _genSoftIRQ()
}
function _genSoftIRQ() {
    _SoftIRQ="softirq=0=0=0=0=0=0=0=0=0=0=0"
}

function checkCPUusage() {
    [ -z $_cpuusage ] && _genCPUusage()
}
function _genCPUusage() {
    #FIXME check on multi core systems
    _cpuusage="cpu0=0=0=0=0=0=0=0=0=0=0"
}

  


#function _check() {
#
#}
#function _gen() {
#
#}