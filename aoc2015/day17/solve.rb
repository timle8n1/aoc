#! /usr/bin/env ruby

input = [50,44,11,49,42,46,18,32,26,40,21,7,18,43,10,47,36,24,22,40]

target = 150

combos = 0
container_count_combos = Hash.new {0}

(2..input.count).each do |container_count|
  input.combination(container_count) do |p|
    combos += 1 if p.sum == 150
    container_count_combos[container_count] += 1 if p.sum == 150
  end
end

pp combos
pp container_count_combos[container_count_combos.keys.min]