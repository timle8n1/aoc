#! /usr/bin/env ruby

module Solver
  def self.look_and_say(input)
    result = ""
    previous = nil
    previous_count = 0
    (0...input.length+1).each do |i|
      if input[i] == previous
        previous_count += 1
      else
        result << "#{previous_count}#{previous}" if previous_count > 0
        previous = input[i]
        previous_count = 1
      end
    end

    result
  end
end

input = "3113322113"
50.times do 
  input = Solver.look_and_say(input)
  puts input.length
end

