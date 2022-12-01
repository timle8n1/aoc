#! /usr/bin/env ruby

module Solver
    def self.solve1(input)
        mostCalories = 0
        currentCalories = 0
        input.each do |line|
            if line == "\n"
                if currentCalories > mostCalories
                    mostCalories = currentCalories
                end
                currentCalories = 0
            else
                currentCalories += line.to_i
            end
        end
        return mostCalories
    end

    def self.solve2(input)
        calorieCounts = []
        currentCalories = 0
        input.each do |line|
            if line == "\n"
                calorieCounts << currentCalories
                currentCalories = 0
            else
                currentCalories += line.to_i
            end
        end
        return calorieCounts.sort.reverse.take(3).reduce(:+)
    end
end

input = File.readlines(ARGV[0])
puts Solver.solve1(input)
puts Solver.solve2(input)