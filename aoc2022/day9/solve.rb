#! /usr/bin/env ruby
require "set"

class Knot
    attr_accessor :x, :y

    def initialize (x,y)
        @x = x
        @y = y
    end

    def ==(other)
        self.x == other.x && self.y == other.y
    end

    def hash
        [x, y].hash
    end
end

module Solver
    def self.solve(input, knot_count)
        knots = Array.new(knot_count) {Knot.new(0,0)}
        
        visits = Set.new()
        visits << [knots[knot_count-1]]

        input.each do |step|
            dir, count = step.split(" ")
            (1..count.to_i).each do |i|
                case dir
                when "R"
                    knots[0].x += 1
                when "L"
                    knots[0].x -= 1
                when "U"
                    knots[0].y -= 1
                when "D"
                    knots[0].y += 1
                end

                (1..knot_count-1).each do |i|
                    tail = knots[i]
                    head = knots[i-1]
                    x_delta = (head.x - tail.x)
                    y_delta = (head.y - tail.y)

                    if x_delta.abs >= 2 || y_delta.abs >= 2
                        tail.x += x_delta.clamp(-1, 1)
                        tail.y += y_delta.clamp(-1, 1)
                    end
                end
                visits << [knots[knot_count-1]]
            end
        end
        visits
    end
end

input = File.readlines(ARGV[0], chomp: true)
puts Solver.solve(input, 2).count
puts Solver.solve(input, 10).count
