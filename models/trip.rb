#!/usr/bin/env ruby

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
        if self.speed > @@maximum_speed || self.speed < @@minimum_speed
            false
        else
            true
        end
    end
end