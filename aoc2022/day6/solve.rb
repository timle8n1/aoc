#! /usr/bin/env ruby
require 'set'

module Solver
    def self.solve(c, marker_length)
        window = c[0, marker_length]

        for i in marker_length..c.length - 1
            return i if Set.new(window).length == marker_length
            window.shift
            window.append(c[i])
        end
    end

    def self.oneLine(c, marker_length)
        (0..c.length - marker_length - 1).each { |i| return i + marker_length if Set.new(c[i, marker_length]).length == marker_length }
    end
end

c = File.readlines(ARGV[0])[0].chars
puts Solver.solve(c, 4)
puts Solver.solve(c, 14)

puts Solver.oneLine(c, 4)
puts Solver.oneLine(c, 14)

