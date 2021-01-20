#!/usr/bin/env ruby

Driver = Struct.new(:driver, :total_distance, :avg_speed)
Trip = Struct.new(:driver, :distance, :hours_driven)

def input_parse(input_text)
    driver_data = []
    trip_data = []
    input_text.each_line do |line|
        parsed_line = line.gsub(/\s+/m, ' ').strip.split(" ")
        type, data = line_parse(parsed_line)
        case
            when type == 'Driver'
                driver_data.push(data)
            when type == 'Trip'
                trip_data.push(data)
        end
    end
    return driver_data, trip_data
end

def line_parse(line)
    case
    when line[0] == 'Driver'
        new_driver = Driver.new(line[1])
        return 'Driver', new_driver
    when line[0] == 'Trip'
        driver = line[1]
        distance = line[4].to_f
        hours = hour_difference(line[2],line[3])
        speed = distance/hours
        if speed_check(speed)
            new_trip = Trip.new(driver, distance, hours)
            return 'Trip', new_trip
        end
    end
end

def time_to_hours(time)
    hour, minute = time.strip.split(":").map(&:to_i)
    total_minutes = hour + minute/60.to_f
    return total_minutes
end

def hour_difference(start, stop)
    return time_to_hours(stop) - time_to_hours(start)
end

def speed_check(speed)
    if speed > 100 || speed < 5
        return false
    else
        return true
    end
end

def trip_aggregate(driver_data,trip_data)
    total_distance = 0
    total_hours = 0
    trip_data.each{|trip|
        if trip.driver == driver_data.driver
            total_distance += trip.distance
            total_hours += trip.hours_driven
        end
    }
    if total_hours > 0
        avg_speed = total_distance/total_hours
    end
    return total_distance, avg_speed
end

def full_trip_aggregate(driver_data, trip_data)
    driver_data.each{|driver|
        driver.total_distance, driver.avg_speed = trip_aggregate(driver, trip_data)
    }
end

def driver_sort(driver_data)
   return driver_data.sort_by {|driver| [-driver.total_distance, driver.driver]}
end

def print_format(driver_data)
    case
    when driver_data.avg_speed.nil?
        return driver_data.driver.to_s + ": " + "%0.0f" % [driver_data.total_distance] + " miles"
    else
        return driver_data.driver.to_s + ": " + "%0.0f" % [driver_data.total_distance] + " miles @ " + "%0.0f" % [driver_data.avg_speed] + " mph"
    end
end