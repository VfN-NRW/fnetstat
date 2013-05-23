#!/bin/sh
# Netmon Nodewatcher (C) 2010-2011 Freifunk Oldenburg
# Update from Wermelskirchen by RubenKelevra 2012 - cyrond@gmail.com
# Lizenz: GPL

echo "<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head></head><body><pre>"
echo "sys:script=v4"
#hostnamen ausgeben
echo -en "sys:hostname="
cat /proc/sys/kernel/hostname
#br-mesh IPv6 Adresse
echo -en "ip6:br-mesh="
ifconfig br-mesh | grep Global | awk '{ print $3 }' | sed -e 's/\/64//g'
#br-mesh IPv4 Adresse
echo -en "ip4:br-mesh="
ifconfig br-mesh | grep 'inet addr' | awk '{ print $2}' | sed -e 's/addr://g'
#uptime & idletime
echo -en "sys:uptime="
cat /proc/uptime | awk '{ print $1 }'
echo -en "sys:idletime="
cat /proc/uptime | awk '{ print $2 }'
#sysinfo memory
echo -en "sys:memory_total="
cat /proc/meminfo | grep 'MemTotal' | awk '{ print $2 }'
echo -en "sys:memory_caching="
cat /proc/meminfo | grep -m 1 'Cached:' | awk '{ print $2 }'
echo -en "sys:memory_buffering="
cat /proc/meminfo | grep 'Buffers' | awk '{ print $2 }'
echo -en "sys:memory_free="
cat /proc/meminfo | grep 'MemFree' | awk '{ print $2 }'
echo -en "sys:processes="
cat /proc/loadavg | awk '{ print $4 }'
echo -en "sys:loadavg="
cat /proc/loadavg | awk '{ print $1 }'
 
IFACES=`cat /proc/net/dev | awk -F: '!/\|/ { gsub(/[[:space:]]*/, "", $1); split($2, a, " "); printf("%s=%s=%s=%s ", $1, a[1], a[9], a[4]) }'`
for entry in $IFACES; do
	iface=`echo $entry | cut -d '=' -f 1`
	rx=`echo $entry | cut -d '=' -f 2`
	tx=`echo $entry | cut -d '=' -f 3`
	drop=`echo $entry | cut -d '=' -f 4`
	echo "traffic:$iface:rx=$rx"
	echo "traffic:$iface:tx=$tx"
	echo "traffic:$iface:drop=$drop"
done



#B.A.T.M.A.N. advanced
if which batctl >/dev/null; then
	BAT_ADV_ORIGINATORS=`batctl o | grep 'No batman nodes in range'`
	if [ "$BAT_ADV_ORIGINATORS" == "" ]; then
		OLDIFS=$IFS
		IFS="
"
		BAT_ADV_ORIGINATORS=`batctl o | grep 'wlan0-1' | awk '/O/ {next} /B/ {next} {print}'`
		for row in $BAT_ADV_ORIGINATORS; do
			originator=`echo $row | awk '{print $1}'`
			next_hop=`echo $row | awk '{print $4}'`
			last_seen=`echo $row | awk '{print $2}'`
			last_seen="${last_seen//s/}"
			link_quality=`echo $row | awk '{print $3}'`
			link_quality="${link_quality//(/}"
			link_quality="${link_quality//)/}"
			
			if [ "$next_hop" == "$originator" ]; then
				echo "bat:originator=$originator"
				echo "bat:last_seen:$originator=$last_seen"
				echo "bat:linkquali:$originator=$link_quality"
			fi
		done
		IFS=$OLDIFS
	fi
fi

MESH_INTERFACE="br-mesh"
CLIENT_INTERFACES="wlan0"
BRCTL="/bin/debug/brctl"
#CLIENTS
SEDDEV=`$BRCTL showstp $MESH_INTERFACE | egrep '\([0-9]\)' | sed -e "s/(//;s/)//" | awk '{ print "s/^  "$2"/"$1"/;" }'`
	
for entry in $CLIENT_INTERFACES; do
	CLIENT_MACS=$CLIENT_MACS`$BRCTL showmacs $MESH_INTERFACE | sed -e "$SEDDEV" | awk '{if ($3 != "yes" && $1 == "'"$entry"'") print $2}'`" "
done
					
i=0
for client in $CLIENT_MACS; do
	i=`expr $i + 1`  #Zähler um eins erhöhen
done
echo "sys:clients=$i"

#
echo "</pre></body></html>"