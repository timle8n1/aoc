#! /usr/bin/env ruby

module Solver
    def self.solve1(input)
        return input.map { |line| 
            line.chomp.chars.each_slice(line.size / 2).map(&:to_a).reduce(&:&)[0]
        }.reduce(0) { |sum, n| sum + Solver.priority(n)}
    end

    def self.solve2(input)
        return input.each_slice(3).map { |lines| 
            lines.map { |line| line.chomp.chars.to_a }.reduce(&:&)[0]
        }.reduce(0) { |sum, n| sum + Solver.priority(n)}
    end

    def self.priority(input)
        inputAsciiValue = input.ord
        if inputAsciiValue >= "a".ord 
            return input.ord - "a".ord + 1
        else 
            return input.ord - "A".ord + 1 + 26
        end
    end
end


input = File.readlines(ARGV[0])
puts Solver.solve1(input)
puts Solver.solve2(input)
