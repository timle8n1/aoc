#! /usr/bin/env ruby

module Solver
    def self.solve1(input)
        return input.reduce(0) { |value, line| 
            line.chomp.split(",").map { |range| Range.new(*range.split("-").map(&:to_i)).to_a }.reduce { |lhs, rhs|
                value + (lhs - rhs == [] ? 1 : rhs - lhs == [] ? 1 : 0)
            }
        }
    end

    def self.solve2(input)
        return input.reduce(0) { |value, line| 
            value + (line.chomp.split(",").map { |range| Range.new(*range.split("-").map(&:to_i)).to_a }.reduce { |lhs, rhs| lhs & rhs }.count > 0 ? 1 : 0)
        } 
    end
end

input = File.readlines(ARGV[0])
puts Solver.solve1(input)
puts Solver.solve2(input)
