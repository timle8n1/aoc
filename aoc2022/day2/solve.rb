#! /usr/bin/env ruby

module Solver
    PICK_SCORE = {
        "X" => 1,
        "Y" => 2,
        "Z" => 3
    }

    ROUND_SCORE = {
        ["A", "X"] => 3,
        ["A", "Y"] => 6,
        ["A", "Z"] => 0,
        ["B", "X"] => 0,
        ["B", "Y"] => 3,
        ["B", "Z"] => 6,
        ["C", "X"] => 6,
        ["C", "Y"] => 0,
        ["C", "Z"] => 3,
    }

    OUTCOME_SCORE = {
        "X" => 0,
        "Y" => 3,
        "Z" => 6
    }

    PICK = {
        ["A", "X"] => "Z",
        ["A", "Y"] => "X",
        ["A", "Z"] => "Y",
        ["B", "X"] => "X",
        ["B", "Y"] => "Y",
        ["B", "Z"] => "Z",
        ["C", "X"] => "Y",
        ["C", "Y"] => "Z",
        ["C", "Z"] => "X",
    }

    def self.solve1(input)
        score = 0
        input.each do |line|
            op, me = line.split(" ")
            score += PICK_SCORE[me]
            score += ROUND_SCORE[[op, me]]
        end
        return score
    end

    def self.solve2(input)
        score = 0
        input.each do |line|
            op, me = line.split(" ")
            score += OUTCOME_SCORE[me]
            score += PICK_SCORE[PICK[[op, me]]]
        end
        return score
    end
end


input = File.readlines(ARGV[0])
puts Solver.solve1(input)
puts Solver.solve2(input)