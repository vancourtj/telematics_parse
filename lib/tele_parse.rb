#!/usr/bin/env ruby

#link the required methods
require_relative 'parsing_methods'

#read in the data file from command line
input_data = ARGF.read
ARGF.close

#parse the text lines into the appropriate commands - Driver or Trip
driver_data, trip_data = input_parse(input_data)

#aggregate the trips up to the driver level
full_trip_aggregate(driver_data, trip_data)

#sort the drivers by total distance
sorted_data = driver_sort(driver_data)

#write the report to a file
output = File.open("output.txt","w")

sorted_data.each{|driver|
    output.puts print_format(driver)
}
output.close