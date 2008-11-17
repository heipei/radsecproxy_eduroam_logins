#!/usr/bin/env ruby
#
#visitors = File.open("visitors.txt", "r")

visitors = STDIN

printf "countries = [ "
visitors.each do |line|
	tuple = line.split(' ')
	printf "[\"#{tuple[1].upcase}\", \"#{tuple[0]}\"], "
end
puts "[] ];"
puts "generated = \"#{Time.now}\";"
