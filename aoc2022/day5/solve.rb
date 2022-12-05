#! /usr/bin/env ruby

module Solver
    def self.solve1(input)
        stacks = make_stacks(input)
        input.each do |line|
            if !line.start_with?("move")
                next
            end
            lineArray = line.chomp.split(" ")
            count = lineArray[1].to_i
            from = lineArray[3].to_i - 1
            to = lineArray[5].to_i - 1
            
            for i in 1..count 
                crate = stacks[from].shift
                stacks[to].unshift(crate)
            end
        end
        stacks.map(&:first).join("")
    end

    def self.solve2(input)
        stacks = make_stacks(input)
        input.each do |line|
            if !line.start_with?("move")
                next
            end
            lineArray = line.chomp.split(" ")
            count = lineArray[1].to_i
            from = lineArray[3].to_i - 1
            to = lineArray[5].to_i - 1
            
            crates = stacks[from].shift(count)
            stacks[to].unshift(*crates)
        end
        stacks.map(&:first).join("")
    end

    def self.make_stacks(input)
        stackCount = input[0].length / 4
        stacks = Array.new(stackCount) { Array.new() }
        input.each do |line|
            if line.start_with?(" 1")
                break
            end
            line.chars.each_slice(4).with_index do |column, index|
                crate = column[1]
                if crate == " "
                    next
                end
                stacks[index].append(crate)
            end
        end
        return stacks
    end
end

input = File.readlines(ARGV[0])
puts Solver.solve1(input)
puts Solver.solve2(input)
