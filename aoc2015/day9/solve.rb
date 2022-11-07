#! /usr/bin/env ruby

module Solver
  
  def self.parse_routes(input)
    cities = {}
    distances = {}

    input.each do |line|
      route, distance = line.split(" = ")
      start, dest = route.split(" to ")

      cities[start] = 1
      cities[dest] = 1

      distances[[start, dest]] = distance.to_i
      distances[[dest, start]] = distance.to_i
    end

    return cities, distances
  end

  def self.route_distances(cities, distances)
    route_lengths = {}

    cities.keys.permutation do |p|
      key = p.join " -> "
      distance = 0
      (0...p.count - 1).each do |i|
        c = p[i]
        d = p[i+1]
        
        distance += distances[[c, d]]
      end
      route_lengths[key] = distance
    end

    route_lengths
  end
end

input = File.readlines("input.txt", :chomp => true)
cities, distances = Solver.parse_routes(input)

routes = Solver.route_distances(cities, distances)
pp routes.sort_by { |key, value| value }.last