require "set"

Cube = Struct.new(:x, :y, :z) do
    def neighbors
        n = []
        n << Cube.new(x+1, y, z)
        n << Cube.new(x-1, y, z)
        n << Cube.new(x, y+1, z)
        n << Cube.new(x, y-1, z)
        n << Cube.new(x, y, z+1)
        n << Cube.new(x, y, z-1)
        n
    end
end

class Parser
    def parse(input)
        cubes = []
        min_x = 100
        max_x = -1
        min_y = 100
        max_y = -1
        min_z = 100
        max_z = -1
        
        input.each do |cube|
            x, y, z = cube.split(",").map(&:to_i)
            min_x = [min_x, x].min
            max_x = [max_x, x].max
            min_y = [min_y, y].min
            max_y = [max_y, y].max
            min_z = [min_z, z].min
            max_z = [max_z, z].max
            cubes << Cube.new(x, y, z)
        end
        [cubes, min_x-1, max_x+1, min_y-1, max_y+1, min_z-1, max_z+1]
    end
end

class VolumeWalker
    attr_accessor :min_x, :max_x, :min_y, :max_y, :min_z, :max_z, :solid_cubes, :visited, :surfaces_hit

    def initialize(min_x, max_x, min_y, max_y, min_z, max_z, solid_cubes)
        @min_x = min_x
        @max_x = max_x
        @min_y = min_y
        @max_y = max_y
        @min_z = min_z
        @max_z = max_z
        @solid_cubes = solid_cubes
    end

    def walk(cube)
        to_visit = []
        visited = Set.new
        to_visit << cube
        surfaces_hit = 0

        while !to_visit.empty?
            visiting = to_visit.pop
            next if visited.include?(visiting)
            visiting.neighbors.each do |n|
                next if out_of_bounds(n)
                if @solid_cubes.include?(n)
                    surfaces_hit += 1
                    next
                end
                to_visit << n
            end
            visited << visiting
        end
        surfaces_hit
    end

    def out_of_bounds(cube)
        return true if cube.x < @min_x
        return true if cube.x > @max_x
        return true if cube.y < @min_y
        return true if cube.y > @max_y
        return true if cube.z < @min_z
        return true if cube.z > @max_z
        false
    end
end

input = File.readlines(ARGV[0], chomp: true)
parser = Parser.new
cubes, min_x, max_x, min_y, max_y, min_z, max_z = parser.parse(input)

surfaces_hit = 0
visited = Set.new
start_cube = Cube.new(min_x, min_y, min_z)
vw = VolumeWalker.new(min_x, max_x, min_y, max_y, min_z, max_z, cubes)
puts vw.walk(start_cube)

