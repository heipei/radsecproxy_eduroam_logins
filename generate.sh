#!/bin/zsh
./mysql_selects.rb|mysql -u radius --password=$(cat .passwd) rz_radius -h komdb.rz.rwth-aachen.de --skip-column-names|./institutions.rb
