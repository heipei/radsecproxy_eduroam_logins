#!/bin/sh
export LD_LIBRARY_PATH=./lib	# Dirty, doesnt work other, unless geoiplookup-libs are installed system-wide!

grep -h Access /var/log/radius/radsecproxy.log*|grep -v 127.0.0.1|grep -v Reject|awk '{print $8}'|sed -e 's/.*@//'|grep -e '^.*\.\w\w$'|sort > institutions.txt
ssh radius3 "grep -h Access /var/log/radius/radsecproxy.log*|grep -v 127.0.0.1|grep -v Reject|awk '{print $8}'|sed -e 's/.*@//'|grep -e '^.*\.\w\w$'|sed -e 's/ statio.*//'|sort" >> institutions.txt

# Do the processing (for processing it into Javascript-readable variables)
cat institutions.txt|sort|uniq -c|sort -r|./institutions.rb > html/countries.js

rm institutions.txt 
