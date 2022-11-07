#! /usr/bin/env ruby

input = Array.new
File.readlines('input.txt').each do |line|
  input << line.to_i
end

part1Count = 0
part1Previous = input[0]
for i in 1...(input.length-1)
    value = input[i].to_i
    if value > part1Previous 
        part1Count += 1
    end
    part1Previous = value
end

puts part1Count

part2Count = 0
part2Previous = input[0] + input[1] + input[2]
for i in 1...(input.length-2)
    value1 = input[i].to_i
    value2 = input[i+1].to_i
    value3 = input[i+2].to_i
    value = value1 + value2 + value3

    # puts i
    # puts part2Previous
    # puts value
    # puts "============="

    if value > part2Previous 
        part2Count += 1
    end
    part2Previous = value
end

puts part2Count