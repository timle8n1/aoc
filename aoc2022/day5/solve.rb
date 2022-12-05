#! /usr/bin/env ruby

module Solver
    def self.solve1(instructions, stacks)
        instructions.each do |line|
            count, from, to = parse_step(line)
            count.times do
                stacks[to - 1].unshift(stacks[from - 1].shift)
            end
        end
        stacks.map(&:first).join("")
    end

    def self.solve2(instructions, stacks)
        instructions.each do |line|
            count, from, to = parse_step(line)
            stacks[to - 1].unshift(*(stacks[from - 1].shift(count)))
        end
        stacks.map(&:first).join("")
    end

    def self.make_stacks(stack_map)
        stacks = Array.new(stack_map[0].length / 4) { Array.new() }
        stack_map.each do |line|
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

    def self.parse_step(line) 
        line.chomp.split(" ").select.with_index { |e, i| i % 2 == 1}.map(&:to_i)
    end
end

input = File.readlines(ARGV[0])
stack_map = input.select { |line| line.match?(/\A\s*\[/) }
instructions = input.select { |line| line.start_with?("move") }
puts Solver.solve1(instructions, Solver.make_stacks(stack_map))
puts Solver.solve2(instructions, Solver.make_stacks(stack_map))
