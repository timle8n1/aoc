#! /usr/bin/env ruby
require "set"

Reindeer = Struct.new(:name, :speed, :flight_time, :rest_time, :race_distance)
input = File.readlines("input.txt", :chomp => true)

reindeer = {}

input.each do |line|
  parse = line.split(" ")
  r = parse[0]
  speed = parse[3].to_i
  flight_time = parse[6].to_i
  rest_time = parse[13].to_i

  reindeer[r] = Reindeer.new(r, speed, flight_time, rest_time, 0)
end

race_time = 2503

reindeer.each do |k,v|
  intervals = race_time / (v.flight_time + v.rest_time)
  last_leg = intervals > 0 ? race_time % (v.flight_time + v.rest_time) : race_time
  
  v.race_distance = v.speed * v.flight_time * intervals
  v.race_distance += [v.flight_time, last_leg].min * v.speed
end

pp reindeer.sort_by { |k, v| v.race_distance }.last[1].race_distance

points = Hash.new { 0 }

(1..2503).each do |second|
  reindeer.each do |k,v|
    intervals = second / (v.flight_time + v.rest_time)
    last_leg = intervals > 0 ? second % (v.flight_time + v.rest_time) : second
  
    v.race_distance = v.speed * v.flight_time * intervals
    v.race_distance += [v.flight_time, last_leg].min * v.speed
  end

  first_place_distance = reindeer.sort_by { |k, v| v.race_distance }.last[1].race_distance

  reindeer.each do |k,v|
    points[k] += 1 if v.race_distance == first_place_distance
  end
end

pp points.sort_by { |k, v| v }.last[1]