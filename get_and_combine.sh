#!/bin/sh

grep -h Access /var/log/radius/radsecproxy.log*|grep -v 127.0.0.1|grep -v Reject|awk '{print $8}'|sed -e 's/.*@//'|grep -e '^.*\.\w\w$'|sort > institutions.txt
ssh radius3 "grep -h Access /var/log/radius/radsecproxy.log*|grep -v 127.0.0.1|grep -v Reject|awk '{print $8}'|sed -e 's/.*@//'|grep -e '^.*\.\w\w$'|sed -e 's/ statio.*//'|sort" >> institutions.txt
cat institutions.txt|sed -e 's/.*\.//'|sort|uniq -c > visitors.txt
#grep -h Access /var/log/radius/radsecproxy.log*|grep -v 127.0.0.1|grep -v Reject|awk '{print $8}'|sed -e 's/.*@//'|sort|sed -e 's/.*\.//'|grep -e '^\w\w$' > visitors.txt
#ssh radius3 "grep -h Access /var/log/radius/radsecproxy.log*|grep -v 127.0.0.1|grep -v Reject|awk '{print $8}'|sed -e 's/.*@//'|sort|sed -e 's/.*\.//'|grep -e '^\w\w$'" >> visitors.txt
cat visitors.txt|./visitors.rb > countries.js
cat institutions.txt|sort|uniq -c|sort -r|./institutions.rb >> countries.js
