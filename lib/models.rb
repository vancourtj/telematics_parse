#!/usr/bin/env ruby

class Driver
    attr_reader :driver_name

    def initialize(driver_name)
        @driver_name = driver_name
        @trips = []
    end

    def add_trip(trip)
        case
        when @driver_name == trip.driver_name && trip.speed_check
            @trips << trip
        end
    end

    def trips
        @trips
    end

    def total_distance
        total_distance_traveled = 0

        self.trips.each{|trip|
            total_distance_traveled += trip.distance
        }
        return total_distance_traveled
    end

    def total_length_hours
        total_time = 0
        self.trips.each{|trip|
            total_time += trip.length_hours
        }
        return total_time
    end

    def avg_speed
        case
        when self.total_length_hours > 0
            return self.total_distance / self.total_length_hours
        end
    end
end

class Trip
    attr_reader :driver_name, :distance

    @@minimum_speed = 5
    @@maximum_speed = 100

    def initialize(driver_name, start_time, end_time, distance)
        @driver_name = driver_name
        @distance = distance.to_f
        @start_time = start_time
        @end_time = end_time
    end

    def length_hours
        start_hour, start_minute = @start_time.strip.split(":").map(&:to_i)
        start_total_time = start_hour + start_minute/60.to_f

        end_hour, end_minute = @end_time.strip.split(":").map(&:to_i)
        end_total_time = end_hour + end_minute/60.to_f

        end_total_time - start_total_time
    end
 
    def speed
        @distance / self.length_hours
    end

    def speed_check
        case
        when self.speed > @@maximum_speed || self.speed < @@minimum_speed
            false
        else
            true
        end
    end
end