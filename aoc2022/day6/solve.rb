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
end

c = File.readlines(ARGV[0])[0].chars
puts Solver.solve(c, 4)
puts Solver.solve(c, 14)
