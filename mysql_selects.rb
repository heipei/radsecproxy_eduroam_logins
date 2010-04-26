#!/usr/bin/env ruby
require 'date'

puts <<EOF
select count(institution) as users, institution  from 
  (select substring_index(username,'@',-1) as institution from 
    (
EOF
   
(2..11).each do |n|
	day = (Date.today-n).strftime("%Y%m%d")
	puts "select username from free#{day} where HomeInstitution not like 'rwth-aachen.de' UNION"
end

puts <<EOF
    select username from free#{(Date.today-1).strftime("%Y%m%d")} where HomeInstitution not like 'rwth-aachen.de'
      group by username order by substring_index(username,'@',-1)) as a)
as b where institution like '%.%' and institution not like '%3gpp%' group by institution order by substring_index(institution,'.',-1) ASC, users DESC, institution ASC;
EOF


