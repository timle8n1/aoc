#! /usr/bin/env ruby

module Solver
  def self.solve(input)

    (0..99).each do |noun|
      (0..99).each do |verb|
        result = execute(input, noun, verb)
        if result == 19690720
          return noun, verb
        end
      end
    end
  end

  def self.execute(input, noun, verb)
    memory = input.clone
    memory[1] = noun
    memory[2] = verb

    memory.each_slice(4) do |e|
      return memory[0].to_i if e[0] == "99"
      lop = memory[e[1].to_i].to_i
      rop = memory[e[2].to_i].to_i

      result = lop.method(e[0] == "1" ? "+" : "*").(rop)
      memory[e[3].to_i] = result
    end
  end
end

input = File.readlines('input.txt', :chomp => true)

noun, verb = Solver.solve(input[0].split(","))

puts 100 * noun + verb
