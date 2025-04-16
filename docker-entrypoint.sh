#!/bin/bash

#echo "...enabling NatSkin"
#grep -q "Set SKIN = nat" /var/www/foswiki/data/Main/SitePreferences.txt || sed -i '/---++ Appearance/a\ \ \ * Set SKIN = nat' /var/www/foswiki/data/Main/SitePreferences.txt

echo "...starting nginx+foswiki"
cd /var/www/foswiki/bin

./foswiki.fcgi -l 127.0.0.1:9000 -n 5 -d

nginx -g "daemon off;"
