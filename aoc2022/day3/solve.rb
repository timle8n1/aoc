#! /usr/bin/env ruby

module Solver
    def self.solve1(input)
        sum = 0
        input.each do |line|
            common = line.chomp.chars.each_slice(line.size / 2).map(&:to_a).reduce(&:&)[0]
            sum += Solver.priority(common)
        end
        return sum
    end

    def self.solve2(input)
        sum = 0
        input.each_slice(3) do |lines|
            common = lines.map { |line| line.chomp.chars.to_a }.reduce(&:&)[0]
            sum += Solver.priority(common)
        end
        return sum
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
