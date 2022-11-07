#! /usr/bin/env ruby
require 'set'

input = File.readlines("input.txt", :chomp => true)[0]

x = 0
y = 0

locations = Set.new()
locations << [x, y]

(0...input.length).each do |i|
  x += 1 if input[i] == ">"
  x -= 1 if input[i] == "<"
  y += 1 if input[i] == "^"
  y -= 1 if input[i] == "v"

  locations << [x, y]
end

puts locations.count

locations = Set.new()

santa_x = 0
santa_y = 0
robo_x = 0
robo_y = 0

locations << [santa_x, santa_y]
locations << [robo_x, robo_y]

(0...input.length).each do |i|
  if i % 2 == 0
    santa_x += 1 if input[i] == ">"
    santa_x -= 1 if input[i] == "<"
    santa_y += 1 if input[i] == "^"
    santa_y -= 1 if input[i] == "v"
    locations << [santa_x, santa_y]
  else
    robo_x += 1 if input[i] == ">"
    robo_x -= 1 if input[i] == "<"
    robo_y += 1 if input[i] == "^"
    robo_y -= 1 if input[i] == "v"
    locations << [robo_x, robo_y]
  end
end

puts locations.count
