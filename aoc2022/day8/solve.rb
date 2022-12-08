#! /usr/bin/env ruby

module Solver
    def self.solve1(input)
        map = Array.new(input.length) { Array.new(input[0].chomp.length) }
        input.each_with_index do |line, index|
            map[index] = line.chomp.split("")
        end
        
        rows = map.size
        columns = map[0].size
        perimeter = (rows * 2) + ((columns - 2) * 2)
        interior_visible = 0

        for row in 1..rows - 2
            for column in 1..columns - 2
                tree = map[row][column]
                
                #check left & right
                visible_left = true
                visible_right = true
                for column_check in 0..columns - 1
                    next if column_check == column
                    if map[row][column_check] >= tree
                        if column_check < column 
                            visible_left = false
                        else
                            visible_right = false
                        end
                    end
                    break if !visible_left && !visible_right
                end
                if visible_left || visible_right
                    interior_visible += 1
                    next
                end

                #check up & down
                visible_up = true
                visible_down = true
                for row_check in 0..rows - 1
                    next if row_check == row
                    if map[row_check][column] >= tree
                        if row_check < row 
                            visible_up = false
                        else
                            visible_down = false
                        end
                    end
                    break if !visible_up && !visible_down
                end
                if visible_up || visible_down
                    interior_visible += 1
                    next
                end
            end
        end

        return perimeter + interior_visible
    end

    def self.solve2(input)
        map = Array.new(input.length) { Array.new(input[0].chomp.length) }
        input.each_with_index do |line, index|
            map[index] = line.chomp.split("")
        end
        
        rows = map.size
        columns = map[0].size
        max_scenic_score = 0

        for row in 1..rows - 2
            for column in 1..columns - 2
                tree = map[row][column]
                
                #check left
                visible_left = 0
                (0..(column - 1)).reverse_each do |left|
                    visible_left += 1
                    if map[row][left] >= tree
                        break
                    end
                end
                
                #check right
                visible_right = 0
                for right in (column + 1)..columns - 1
                    visible_right += 1   
                    if map[row][right] >= tree
                        break
                    end
                end

                #check up
                visible_up = 0
                (0..(row - 1)).reverse_each do |up|
                    visible_up += 1   
                    if map[up][column] >= tree
                        break
                    end
                end
                
                #check down
                visible_down = 0
                for down in (row + 1)..rows - 1
                    visible_down += 1   
                    if map[down][column] >= tree
                        break
                    end
                end
                
                scenic_score = visible_left * visible_right * visible_up * visible_down
                if scenic_score > max_scenic_score
                    max_scenic_score = scenic_score
                end
            end
        end
        max_scenic_score
    end
end

input = File.readlines(ARGV[0])
puts Solver.solve1(input)
puts Solver.solve2(input)
