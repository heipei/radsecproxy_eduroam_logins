#!/bin/sh

# We are using the GeoLite City Database from Maxmind
# The binary database is used, which is updated monthly and can be downloaded
# at http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz

# More information: http://www.maxmind.com/app/geolitecity

wget -nv http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
gunzip -f GeoLiteCity.dat.gz
