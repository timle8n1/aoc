#! /usr/bin/env ruby

module Solver
    def self.solve1(input)
        counts = Array.new(input[0].length - 1, 0) 
        input.each do |line|
            digits = line.split("")
            digits.each_with_index do |digit, index|
                if digit == "\n"
                    next
                end
                case digit
                when "0"
                    counts[index] -= 1
                when "1"
                    counts[index] += 1
                end
            end
        end
        gamma = counts.map { |count| count > 0 ? 1 : 0 }.join.to_i(2)
        epsilon = counts.map { |count| count < 0 ? 1 : 0 }.join.to_i(2)
        return gamma * epsilon
    end

    def self.solve2(input)
        ox = Solver.findDigit(input, true).strip.to_i(2)
        co2 = Solver.findDigit(input, false).strip.to_i(2)
        return ox * co2
    end

    def self.findDigit(input, keepMost)
        digit = 0
        while true
            input = Solver.recurse(input, digit, keepMost)
            digit += 1
            if input.length == 1 
                break
            end
        end
        return input[0]
    end

    def self.recurse(input, digitPosition, keepMost)
        oneArray = Array.new()
        zeroArray = Array.new()
        input.each do |line|
            digits = line.split("")
            digit = line[digitPosition]
            if digit == "\n"
                next
            end
            case digit
            when "0"
                zeroArray.append(line)
            when "1"
                oneArray.append(line)
            end
        end
        if keepMost
            return oneArray.length < zeroArray.length ? zeroArray : oneArray
        end

        return oneArray.length < zeroArray.length ? oneArray : zeroArray
    end
end

input = File.readlines('input.txt')
puts Solver.solve1(input)
puts Solver.solve2(input)
