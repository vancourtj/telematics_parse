#!/usr/bin/env ruby

class TextParse
    def initialize(line)
        @line = line
    end

    def parse
        @line.gsub(/\s+/m, ' ').strip.split(" ")
    end

    def type
        self.parse[0]
    end

    def data
        case self.type
            when 'Driver'
                return parse[1]
            when 'Trip'
                return [parse[1], parse[2], parse[3], parse[4].to_f]
        end
    end
end