#!/usr/bin/env ruby
#

visitors = STDIN

printf "institutions = \""
printf "<table class=\\\"institutions\\\">"
printf "<tr><th><b>Institute</b></th><th><b>Visitors</b></th></tr>"

visitors.each do |line|
	tuple = line.split(' ')
	printf "<tr><td>#{tuple[1]}</td><td>#{tuple[0]}</td></tr>"
end
printf "</table>\";"
