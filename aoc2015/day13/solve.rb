#! /usr/bin/env ruby
require "set"

input = File.readlines("input.txt", :chomp => true)

guests = Set.new
guests_with_me = Set.new
guests_with_me << "me"

happy = Hash.new(0)

input.each do |line|
  parse = line.split(" ")
  subject = parse[0]
  gain_lose = parse[2]
  amount = parse[3].to_i
  amount = 0 - amount if gain_lose == "lose"
  neighbor = parse[10].chomp(".")

  guests << subject
  guests_with_me << subject
  happy["#{subject}:#{neighbor}"] = amount
end

happy_arrangements = {}
guests.to_a.permutation.each do |p|
  total_happy = 0
  (0...p.length).each do |i|
    subject = p[i]
    neighbor1 = p[i+1]
    neighbor2 = p[i-1]
    neighbor1 = p[0] if neighbor1 == nil

    total_happy += happy["#{subject}:#{neighbor1}"]
    total_happy += happy["#{subject}:#{neighbor2}"]
  end

  happy_arrangements[p.join(" <-> ")] = total_happy
end

pp happy_arrangements.sort_by { |key, value| value }.last[1]

happy_arrangements = {}
guests_with_me.to_a.permutation.each do |p|
  total_happy = 0
  (0...p.length).each do |i|
    subject = p[i]
    neighbor1 = p[i+1]
    neighbor2 = p[i-1]
    neighbor1 = p[0] if neighbor1 == nil

    total_happy += happy["#{subject}:#{neighbor1}"]
    total_happy += happy["#{subject}:#{neighbor2}"]
  end

  happy_arrangements[p.join(" <-> ")] = total_happy
end

pp happy_arrangements.sort_by { |key, value| value }.last[1]
