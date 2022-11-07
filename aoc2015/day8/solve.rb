#! /usr/bin/env ruby

module Solver
  def self.decode(input)
    code_count = 0
    mem_count = 0

    input.each do |line|
      code_count += line.length
      
      escape_count = 2
      escaping = false
      (1...line.length-1).each do |i|
        if escaping
          escape_count += 1 if line[i] == "\\"
          escape_count += 1 if line[i] == "\""
          escape_count += 3 if line[i] == "x"
          escaping = false
        elsif line[i] == "\\"
          escaping = true
        end
      end

      mem_count += (line.length - escape_count)
    end

    return code_count, mem_count
  end

  def self.encode(input)
    code_count = 0
    encode_count = 0

    input.each do |line|
      code_count += line.length

      escape_count = 4
      (1...line.length-1).each do |i|
        escape_count += 1 if line[i] == "\\"
        escape_count += 1 if line[i] == "\""
      end

      encode_count += (line.length + escape_count)
    end

    return code_count, encode_count
  end
end

input = File.readlines("input.txt", :chomp => true)
code, mem = Solver.decode(input)
puts code - mem

code, encode = Solver.encode(input)
puts encode - code