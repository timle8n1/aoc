#! /usr/bin/env ruby

input = File.readlines("input.txt", :chomp => true)[0]

red_indexes = []
offset = 0
while true
  index = input.index("\":\"red\"", offset)
  break if index == nil
  red_indexes << index
  offset = index + 6
end

start_blocks = []
red_indexes.each do |ri|
  index = ri-1
  close_count = 0
  while true
    if input[index] == "{"
      if close_count == 0
        start_blocks << index
        break
      else
        close_count -= 1
      end
    elsif input[index] == "}"
      close_count += 1
    end
    index = index - 1
  end
end

ranges = []
start_blocks.each do |pi|
  index = pi+1
  open_count = 1
  while true
    if input[index] == "{"
      open_count += 1
    elsif input[index] == "}"
      open_count -= 1
    end

    if open_count == 0
      ranges << (pi..index)
      break
    end

    index += 1
  end
end

digits = []
digits_ignore_red = []

current_digit = ""
minus = false
input.chars.each.with_index do |c,i|
  if c.ord >= 48 && c.ord <= 57
    current_digit << c
  else
    if current_digit != ""
      digits << current_digit.to_i 
      ignore = false
      ranges.each do |range|
        ignore = range.cover?(i-1)
        break if ignore
      end
      digits_ignore_red << current_digit.to_i unless ignore
      current_digit = ""
    elsif c == "-"
      current_digit << c
    end
  end
end

pp digits.sum
pp digits_ignore_red.sum