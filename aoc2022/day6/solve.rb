#! /usr/bin/env ruby

module Solver
    def self.solve(c, marker_length)
        for i in marker_length..(c.length - 1) do
            match = true
            for j in 0..marker_length-1 do
                for k in j+1..marker_length-1 do
                    if c[i-j] == c[i-k]
                        match = false
                        break
                    end
                    if !match 
                        break
                    end
                end
            end
            if match
                return i + 1
            end
        end
    end
end

c = File.readlines(ARGV[0])[0].chars
puts Solver.solve(c, 4)
puts Solver.solve(c, 14)
