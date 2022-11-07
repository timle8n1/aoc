#! /usr/bin/env ruby

input = File.readlines("input.txt", :chomp => true)

square_feet_paper = 0
feet_ribbon = 0

input.each do |present|
  l, w, h = present.split("x").map(&:to_i)
  
  side1 = l * w
  side2 = l * h
  side3 = w * h

  sides = [l,w,h].sort

  square_feet_paper += 2 * side1 + 2 * side2 + 2 * side3
  square_feet_paper += [side1, side2, side3].min

  feet_ribbon += sides[0] + sides[0] + sides[1] + sides[1]
  feet_ribbon += l*w*h
end

puts square_feet_paper
puts feet_ribbon