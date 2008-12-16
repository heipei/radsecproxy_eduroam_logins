#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/lib/geoip_city'
require 'resolv'
require 'rubygems'

visitors = STDIN
db = GeoIPCity::Database.new('GeoLiteCity.dat')

institutions = "institutions = [ "
institutions_breakdown = "institution_breakdown = \""
institutions_breakdown += "<table class=\\\"institutions\\\">"
institutions_breakdown += "<tr><th><b>Institute</b></th><th><b>Requests</b></th></tr>"

visitors.each do |line|
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
	city = institute[:city].scan(/[a-z,A-Z,\,, ]+/).join('')	# filter out non-ascii-chars, js or google may choke on these
	country = institute[:country_name]
	country_code = institute[:country_code]
	institutions += "[\"#{city}, #{country}\", \"#{tuple[-1]}\", \"#{tuple[0]}\", \"#{country_code}\"], "
	institutions_breakdown += "<tr><td>#{tuple[1]}</td><td>#{tuple[0]}</td></tr>"

end

institutions += "[] ];"
institutions_breakdown += "</table>\";"

puts institutions
puts institutions_breakdown

puts "generated = \"#{Time.now}\";"
