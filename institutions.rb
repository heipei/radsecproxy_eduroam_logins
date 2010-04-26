#!/usr/bin/env ruby

require 'resolv'
require 'rubygems'
require 'geoip_city'

visitors = STDIN
db = GeoIPCity::Database.new('GeoLiteCity.dat')

columns = 4

institutions = "institutions = [ "
institutions_breakdown = Array.new(columns, "")
institutions_breakdown[0] = "institution_breakdown = \""
institutions_breakdown[0] = "institution_breakdown = \"<table><tr>"
(0..columns-1).each do |n|
	institutions_breakdown[n] += "<td><table class=\\\"institutions\\\">"
	institutions_breakdown[n] += "<tr><th></th><th><b>Institute</b></th><th><b>Users</b></th></tr>"
end

i = 1
visitors_string = visitors.read
column_length = (visitors_string.split("\n").length / columns) + 1

visitors_string.each do |line|
	tuple = line.split(' ')
	begin
		institute = db.look_up(Resolv.getaddress("www." + tuple[1]))
	rescue
		begin
			institute = db.look_up(Resolv.getaddress(tuple[1]))
		rescue
			next
		end
	end
	if(institute[:city]) then
		city = institute[:city].scan(/[a-z,A-Z,\,, ]+/).join('')	# filter out non-ascii-chars, js or google may choke on these
	end
	country = institute[:country_name]
	country_code = institute[:country_code]
	latitude = institute[:latitude]
	longitude = institute[:longitude]
	institutions += "[\"#{city}, #{country}\", \"#{tuple[-1]}\", \"#{tuple[0]}\", \"#{country_code}\", \"#{latitude}\", \"#{longitude}\"], "
	institutions_breakdown[i/column_length] += "<tr><td><img src=\\\"flags/#{country_code.downcase}.png\\\" alt=\\\"\\\"></td><td><a href=\\\"http\://www.#{tuple[1]}\\\">#{tuple[1]}</a></td><td>#{tuple[0]}</td></tr>"
	i = i+1
end

institutions += "[] ];"
(0..columns-1).each do |n|
	institutions_breakdown[n] += "</table></td>"
end
institutions_breakdown[columns-1] += "</table></tr></table>\";"

puts institutions
institutions_breakdown.each do |i|
	printf(i)
end
puts ""

puts "generated = \"#{Time.now}\";"
