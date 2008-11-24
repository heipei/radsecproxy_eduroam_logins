#!/bin/sh
export LD_LIBRARY_PATH=./lib
grep -h Access /var/log/radius/radsecproxy.log*|grep -v 127.0.0.1|grep -v Reject|awk '{print $8}'|sed -e 's/.*@//'|grep -e '^.*\.\w\w$'|sort > institutions.txt
ssh radius3 "grep -h Access /var/log/radius/radsecproxy.log*|grep -v 127.0.0.1|grep -v Reject|awk '{print $8}'|sed -e 's/.*@//'|grep -e '^.*\.\w\w$'|sed -e 's/ statio.*//'|sort" >> institutions.txt

# Only extract TLD (i.e. country) from the institution's domains
#cat institutions.txt|sed -e 's/.*\.//'|sort|uniq -c|./visitors.rb > html/countries.js

#grep -h Access /var/log/radius/radsecproxy.log*|grep -v 127.0.0.1|grep -v Reject|awk '{print $8}'|sed -e 's/.*@//'|sort|sed -e 's/.*\.//'|grep -e '^\w\w$' > visitors.txt
#ssh radius3 "grep -h Access /var/log/radius/radsecproxy.log*|grep -v 127.0.0.1|grep -v Reject|awk '{print $8}'|sed -e 's/.*@//'|sort|sed -e 's/.*\.//'|grep -e '^\w\w$'" >> visitors.txt

# Also append breakdown per institution
cat institutions.txt|sort|uniq -c|sort -r|./institutions.rb > html/countries.js

#rm institutions.txt 
