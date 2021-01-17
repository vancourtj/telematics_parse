#!/usr/bin/env ruby

require_relative 'parsing_methods'

driver_data = []
trip_data = []

ARGF.each_line do |line|
    parsed_line = line.gsub(/\s+/m, ' ').strip.split(" ")
    type, data = line_parse(parsed_line)
    case
    when type == 'Driver'
        driver_data.push(data)
    when type == 'Trip'
        trip_data.push(data)
    end
end
ARGF.close

driver_data.each{|driver|
    driver.total_distance, driver.avg_speed = trip_aggregate(driver, trip_data)
}

sorted_data = trip_sort(driver_data)

output = File.open("output.txt","w")

sorted_data.each{|driver|
    output.puts print_format(driver)
}
output.close