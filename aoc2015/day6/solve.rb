#! /usr/bin/env ruby

COMMANDS = {
  "toggle" => ->(lights, x, y) { lights[x][y] ^= 1 },
  "turn on" => ->(lights, x, y) { lights[x][y] = 1 },
  "turn off" => ->(lights, x, y) { lights[x][y] = 0 }
}

PHASE_TWO = {
  "toggle" => ->(lights, x, y) { lights[x][y] += 2 },
  "turn on" => ->(lights, x, y) { lights[x][y] += 1 },
  "turn off" => ->(lights, x, y) { lights[x][y] -= 1 if lights[x][y] > 0 }
}

input = File.readlines("input.txt", :chomp => true)
lights = Array.new(1000) { Array.new(1000, 0) }

position_regex = /(.+) (\d+,\d+) through (\d+,\d+)/

input.each do |line|
  command, start_pos, end_pos = line.match(position_regex).captures

  x1, y1 = start_pos.split(",").map(&:to_i)
  x2, y2 = end_pos.split(",").map(&:to_i)

  (x1..x2).each do |x|
    (y1..y2).each do |y|
      PHASE_TWO[command].call(lights, x, y)  
    end
  end
end

count = 0
lights.each do |line|
  line.each do |light|
    count += light
  end
end

puts count

