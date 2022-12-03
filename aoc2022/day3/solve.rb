#! /usr/bin/env ruby

class String
    def priority
        self.ord >= "a".ord ? self.ord - "a".ord + 1 : self.ord - "A".ord + 1 + 26
    end
end

module Solver
    def self.solve1(input)
        return input.map { |line| 
            line.chomp.chars.each_slice(line.size / 2).map(&:to_a).reduce(&:&)[0]
        }.map(&:priority).reduce(&:+)
    end

    def self.solve2(input)
        return input.each_slice(3).map { |lines| 
            lines.map { |line| line.chomp.chars.to_a }.reduce(&:&)[0]
        }.map(&:priority).reduce(&:+)
    end
end

input = File.readlines(ARGV[0])
puts Solver.solve1(input)
puts Solver.solve2(input)
