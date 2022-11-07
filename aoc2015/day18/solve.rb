#! /usr/bin/env ruby

module Solver
  def self.solve(input, apply_stuck)
    (1..100).each do |step|
      reference = input.map(&:clone)
      (0...100).each do |y|
        (0...100).each do |x|
          neighbor_on_count = 0

          neighbor_on_count += 1 if x > 0 && y > 0 && reference[y-1][x-1] == "#"
          neighbor_on_count += 1 if y > 0 && reference[y-1][x] == "#"
          neighbor_on_count += 1 if x < 99 && y > 0 && reference[y-1][x+1] == "#"
          neighbor_on_count += 1 if x < 99 && reference[y][x+1] == "#"
          neighbor_on_count += 1 if x < 99 && y < 99 && reference[y+1][x+1] == "#"
          neighbor_on_count += 1 if y < 99 && reference[y+1][x] == "#"
          neighbor_on_count += 1 if x > 0 && y < 99 && reference[y+1][x-1] == "#"
          neighbor_on_count += 1 if x > 0 && reference[y][x-1] == "#"

          if reference[y][x] == "#"
            input[y][x] = "." if neighbor_on_count < 2 || neighbor_on_count > 3
          else
            input[y][x] = "#" if neighbor_on_count == 3
          end 

          if apply_stuck
            input[0][0] = "#"
            input[0][99] = "#"
            input[99][0] = "#"
            input[99][99] = "#"
          end
        end
      end
    end

    input
  end
end

input = File.readlines("input.txt", :chomp => true)
input_stuck = input.map(&:clone)

los_count = 0
Solver.solve(input, false).each do |line|
  los_count += line.count("#")
end
puts los_count

los_count = 0
Solver.solve(input_stuck, true).each do |line|
  los_count += line.count("#")
end
puts los_count



