#!/usr/bin/env ruby

require_relative 'driver_model'
require_relative 'trip_model'

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
        parsed_line = line.gsub(/\s+/m, ' ').strip.split(" ")
        type, data = line_parse(parsed_line)
        case
            when type == 'Driver'
                driver_list.push(data)
            when type == 'Trip'
                trip_list.push(data)
        end
    end
    return driver_list, trip_list
end

def line_parse(line)
    case
    when line[0] == 'Driver'
        new_driver = Driver.new(line[1])
        return 'Driver', new_driver
    when line[0] == 'Trip'
        driver = line[1]
        start_time = line[2]
        end_time = line[3]
        distance = line[4].to_f

        new_trip = Trip.new(driver,start_time, end_time,distance)

        return 'Trip', new_trip
    end
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
        output.puts print_format(driver)
    }

    output.close
end

def print_format(driver)
    case
    when driver.avg_speed.nil?
        return driver.driver_name + ": " + "%0.0f" % [driver.total_distance] + " miles"
    else
        return driver.driver_name + ": " + "%0.0f" % [driver.total_distance] + " miles @ " + "%0.0f" % [driver.avg_speed] + " mph"
    end
end