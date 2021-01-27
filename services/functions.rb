#!/usr/bin/env ruby

require './models/driver'
require './models/trip'
require './services/textparse'

def full_data_parse(input_text)
    driver_list, trip_list = class_initialization(input_text)

    trip_addition(driver_list, trip_list)
    
    driver_sort(driver_list)
        
    file_out(driver_list)
end

def class_initialization(input_text)
    driver_list = []
    trip_list = []

    input_text.each_line do |line|
        new_line = TextParse.new(line)
        
        case new_line.type
            when 'Driver'
                driver_list.push(Driver.new(new_line.data))
            when 'Trip'
                trip_list.push(Trip.new(new_line.data[0],new_line.data[1],new_line.data[2],new_line.data[3]))
        end
    end

    return driver_list, trip_list
end

def trip_addition(driver_list, trip_list)
    driver_list.each{|driver|
        trip_list.each{|trip|
            driver.add_trip(trip)
        }
    }
end

def driver_sort(driver_list)
    driver_list.sort! {|a,b| (a.total_distance == b.total_distance) ? a.driver_name <=> b.driver_name : b.total_distance <=> a.total_distance}
end

def file_out(driver_list)
    output = File.open("output.txt","w")
    
    driver_list.each{|driver|
        output.puts driver.print_format
    }

    output.close
end