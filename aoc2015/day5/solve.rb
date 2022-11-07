#! /usr/bin/env ruby
require 'set'

input = File.readlines("input.txt", :chomp => true)

nice = 0
input.each do |string|
  next if /ab|cd|pq|xy/.match?(string)

  vowel_count = 0
  vowel_count += string.count("a")
  vowel_count += string.count("e") 
  vowel_count += string.count("i")
  vowel_count += string.count("o")
  vowel_count += string.count("u")
  next unless vowel_count >= 3

  repeat = false
  (0...string.length - 1).each do |i|
    repeat = true if string[i] == string[i+1]
    break if repeat
  end
  next unless repeat

  nice += 1
end

puts nice

nice = 0
input.each do |string|
  repeat = false
  (0...string.length - 2).each do |i|
    repeat = true if string[i] == string[i+2]
    break if repeat
  end
  next unless repeat

  repeat = false
  (0...string.length - 3).each do |i|
    (i+2...string.length-1).each do |j|
      repeat = true if (string[i] + string[i+1] == string[j] + string[j+1])
      break if repeat
    end
    break if repeat
  end
  next unless repeat

  nice += 1
end

puts nice