#! /usr/bin/env ruby

module Solver
    def self.solve1(input)
        hPos = 0
        depth = 0
        input.each do |line|
            (instruction, value) = line.split(" ")
            case instruction
            when "forward"
                hPos += value.to_i
            when "down"
                depth += value.to_i
            when "up"
                depth -= value.to_i
            end
        end
        return hPos * depth
    end

    def self.solve2(input)
        hPos = 0
        depth = 0
        aim = 0
        input.each do |line|
            (instruction, value) = line.split(" ")
            case instruction
            when "forward"
                hPos += value.to_i
                depth += aim * value.to_i
            when "down"
                aim += value.to_i
            when "up"
                aim -= value.to_i
            end
        end
        return hPos * depth
    end
end

input = File.readlines('input.txt')
puts Solver.solve1(input)
puts Solver.solve2(input)