#!/usr/bin/env ruby

class Driver
    attr_reader :driver_name

    def initialize(driver_name)
        @driver_name = driver_name
        @trips = []
    end

    def add_trip(trip)
        if @driver_name == trip.driver_name && trip.speed_check
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
        if self.total_length_hours > 0
            return self.total_distance / self.total_length_hours
        end
    end
end