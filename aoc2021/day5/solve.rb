#! /usr/bin/env ruby

module Solver
    def self.solve1(input)
        vents = Hash.new(0)
        input.each do |line|
            (one, two) = line.split(" -> ")
            (x1, y1) = one.split(",").map(&:to_i)
            (x2, y2) = two.split(",").map(&:to_i)

            unless x1 == x2 || y1 == y2 
                next
            end

            if x1 == x2
                ymin = y1 < y2 ? y1 : y2
                ymax = y1 > y2 ? y1 : y2
                for y in ymin..ymax
                    vents[[x1,y]] += 1
                end
            elsif y1 == y2 
                xmin = x1 < x2 ? x1 : x2
                xmax = x1 > x2 ? x1 : x2
                for x in xmin..xmax
                    vents[[x,y1]] += 1
                end
            end
        end
        return vents.select {|k,v| v > 1}.count
    end

    def self.solve2(input)
        vents = Hash.new(0)
        input.each do |line|
            (one, two) = line.split(" -> ")
            (x1, y1) = one.split(",").map(&:to_i)
            (x2, y2) = two.split(",").map(&:to_i)

            ymin = [y1, y2].min
            ymax = [y1, y2].max
            xmin = [x1, x2].min
            xmax = [x1, x2].max
            
            if x1 == x2 || y1 == y2
                for x in xmin..xmax
                    for y in ymin..ymax
                        vents[[x,y]] += 1
                    end
                end
           elsif (xmax - xmin) == (ymax - ymin)
                xDelta = x2 < x1 ? -1 : 1
                yDelta = y2 < y1 ? -1 : 1
                for i in 0..(xmax-xmin)
                    x = x1 + (xDelta * i)
                    y = y1 + (yDelta * i)
                    vents[[x,y]] += 1
                end
            end
        end
        return vents.select {|k,v| v > 1}.count
    end
end

input = File.readlines('input.txt')
puts Solver.solve1(input)
puts Solver.solve2(input)