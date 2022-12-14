class SandSim
    attr_accessor :map, :source, :grain, :max_x, :min_x, :max_y

    def initialize(map, source)
        @map = map
        @source = source
        @max_x = map[0].length - 1
        @max_y = map.length - 1
    end

    def drop
        grain = [1, source[1]]

        while true
            #puts "grain:#{grain.join(",")}"
            down = [grain[0] + 1, grain[1]]
            left = [grain[0] + 1, grain[1] - 1]
            right = [grain[0] + 1, grain[1] + 1]
            if down[0] <= @max_y
                if map[down[0]][down[1]] == "."
                    grain = down
                    next
                end
                if left[1] >= 0
                    if map[left[0]][left[1]] == "."
                        grain = left
                        next
                    end
                else 
                    return nil
                end
                if right[1] <= @max_x
                    if map[right[0]][right[1]] == "."
                        grain = right
                        next
                    end
                else 
                    return nil
                end
                return grain
            else
                return nil
            end
        end
    end
end

class Parser
    attr_accessor :rocks, :min_x, :max_x, :max_y

    def parse(input)
        @rocks = []
        @min_x = 9999999999999
        @max_x = 0
        @max_y = 0
        input.each do |line|
            points = line.split(" -> ").map { |p| p.split(",") }.map { |a| [a[1].to_i, a[0].to_i ]}
            points.each do |p|
                @max_x = p[1] if p[1] > @max_x
                @min_x = p[1] if p[1] < @min_x
                @max_y = p[0] if p[0] > @max_y
            end
                
            @rocks << points
        end
    end

    def to_map
        rows = @max_y + 1
        columns = @max_x - @min_x + 1
        art = Array.new(rows) { Array.new(columns) {"."} }
        @rocks.each do |rock|
            pp = nil
            rock.each do |p|
                art[p[0]][p[1] - @min_x] = "#"
                if pp != nil
                    start_x = (p[1] < pp[1] ? p[1] : pp[1]) - @min_x
                    end_x = (p[1] > pp[1] ? p[1] : pp[1]) - @min_x
                    start_y = p[0] < pp[0] ? p[0] : pp[0]
                    end_y = p[0] > pp[0] ? p[0] : pp[0]
            
                    for x in start_x..end_x
                        for y in start_y..end_y
                            art[y][x] = "#"
                        end
                    end
                end
                pp = p
            end
        end
        return art
    end
end

input = File.readlines(ARGV[0], chomp: true)
parser = Parser.new
parser.parse(input)

source = [0, 500 - parser.min_x]

map = parser.to_map
map[source[0]][source[1]] = "+"

sim = SandSim.new(map, source)
grain = sim.drop
while !grain.nil?
    map[grain[0]][grain[1]] = "O"
    grain = sim.drop
end

map.each do |row|
    puts row.join
end


sand = 0
map.each do |row|
    row.each do |p|
        sand +=1 if p == "O"
    end
end
puts sand
