#! /usr/bin/env ruby

module Solver
    def self.solve1(input)
        draws = input[0].split(",")
        boards = input.drop(2)
        boardCount = input.length / 6

        minWin = draws.count
        maxWin = 0
        minDraw = nil
        maxDraw = nil
        minWinner = nil
        maxWinner = nil
        for i in 0..boardCount-1
            board = boards.slice(i * 6, 5)
            (index, draw, board2D) = Solver.drawsToWin(draws, board)
            if index < minWin
                minWin = index
                minWinner = board2D
                minDraw = draw
            end

            if index > maxWin
                maxWin = index
                maxWinner = board2D
                maxDraw = draw
            end
        end

        minSum = 0
        minWinner.each do |row|
            row.each do |cell|
                if cell == "*"
                    next
                end
                minSum += cell.to_i
            end
        end

        maxSum = 0
        maxWinner.each do |row|
            row.each do |cell|
                if cell == "*"
                    next
                end
                maxSum += cell.to_i
            end
        end
        
        return [minSum * minDraw.to_i, maxSum * maxDraw.to_i]
    end

    def self.drawsToWin(draws, board)
        board2D = Array.new(5) { Array.new(5) }
        board.each_with_index do |line, index|
            board2D[index] = line.split(" ")
        end
        draws.each_with_index do |draw, index|
            for column in 0..4
                for row in 0..4
                    value = board2D[column][row]
                    if value == draw
                        board2D[column][row] = "*"

                        if board2D[column] == ["*","*","*","*","*"]
                            return [index, draw, board2D]
                        end
                        columnCheck = [board2D[0][row],board2D[1][row],board2D[2][row],board2D[3][row],board2D[4][row]]
                        if columnCheck == ["*","*","*","*","*"]
                            return [index, draw, board2D]
                        end
                    end
                end
            end
        end
    end
end

input = File.readlines('input.txt')
puts Solver.solve1(input)