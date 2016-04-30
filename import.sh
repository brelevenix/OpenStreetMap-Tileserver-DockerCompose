#import command
echo "exec import.sh"
#get core
PROCS=$(grep --count ^processor /proc/cpuinfo)
echo $PROCS > /var/lib/start/procs.txt

#get RAM and keep 3/4 for cache
RAM=$(grep 'MemTotal' /proc/meminfo | perl -pe "s/.*: (.+) .*/\1/")
CACHE=$(($RAM * 3 / 4000))
echo $CACHE > /var/lib/start/ram.txt

#import 
#---drop: to avoid index for update 
#--flat-nodes: to optimise node storage
osm2pgsql --create --slim --drop --cache $CACHE --number-processes $PROCS --flat-nodes /osm/nodes.bin --database gis --username osm --host pg --port 5432 /osm/import.osm.pbf
