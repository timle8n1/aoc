#! /usr/bin/env ruby
require "set"

class Position
    attr_accessor :x, :y, :parent, :g, :h, :f

    def initialize(x, y, parent)
        @x = x
        @y = y
        @parent = parent
        @g = 0
        @h = 0
        @f = 0
    end

    def manhattan_distance(other)
        return (self.x - other.x).abs + (self.y - other.y).abs
    end

    def near(max_x, max_y)
        n = []
        if self.x > 0 
            n << Position.new(self.x - 1, self.y, self)
        end
        if self.y > 0 
            n << Position.new(self.x, self.y - 1, self)
        end
        if self.x < max_x
            n << Position.new(self.x + 1, self.y, self)
        end
        if self.y < max_y
            n << Position.new(self.x, self.y + 1, self)
        end
        n
    end

    def eql?(other)
        self.==(other)
    end

    def ==(other)
        self.class == other.class &&
            self.x == other.x && 
            self.y == other.y
    end

    def hash
        [x, y].hash
    end

    def to_s
        "#{self.y},#{self.x}"
    end

    def route
        parent = @parent
        route = []
        until parent == nil
            route << parent
            parent = parent.parent
        end
        route
    end
end

class RouteFinder
    attr_accessor :map, :max_x, :max_y, :min_y, :min_x

    def initialize(map)
        @map = map
        @max_y = map.length - 1
        @max_x = map[0].length - 1
        @min_y = 0
        @min_x = 0
    end

    def find_best_route(start_pos, best_signal_pos)
        openset = Set.new
        closedset = Set.new
        openset << start_pos

        current = nil
        while openset.length > 0
            current = openset.first
            openset.each do |n|
                if n.f < current.f
                    current = n
                end
            end
            openset.delete(current)
            closedset << current

            if current == best_signal_pos
                return current
            end

            current_height = @map[current.y][current.x].ord
            current.near(@max_x, @max_y).each do |child|
                if closedset.include?(child)
                    next
                end

                child_height = @map[child.y][child.x].ord
                if (child_height - current_height) > 1
                    next
                end
                
                child.g = current.g + 1
                child.h = best_signal_pos.manhattan_distance(child)
                child.f = child.g + child.h

                openset << child
            end
        end
        return nil
    end
end

class Parser
    attr_accessor :map, :start_pos, :best_signal_pos, :possible_starts

    def parse(input)
        @possible_starts = []
        @map = input.map { |l| l.split("") }
        map.each_with_index do |row, y|
            row.each_with_index do |height, x|
                case height
                when "S"
                    @start_pos = Position.new(x, y, nil)
                    map[y][x] = "a"
                    @possible_starts << @start_pos
                when "E"
                    @best_signal_pos = Position.new(x, y, nil)
                    map[y][x] = "z"
                when "a"
                    position = Position.new(x, y, nil)
                    @possible_starts << position
                end
            end
        end
    end
end

input = File.readlines(ARGV[0], chomp: true)
parser = Parser.new
parser.parse(input)

route_finder = RouteFinder.new(parser.map)
result = route_finder.find_best_route(parser.start_pos, parser.best_signal_pos)
puts result.route.length

possible_results = []
parser.possible_starts.each do |possible|
    possible_results << route_finder.find_best_route(possible, parser.best_signal_pos)
end
shortest_route = possible_results.reject{ |r| r == nil}.sort_by{ |r| r.route.length }.first
puts shortest_route.route.length
