class Rock
    attr_accessor :shape, :left_index, :bottom_index

    def initialize(shape)
        @shape = shape
        @left_index = nil
        @bottom_index = nil
    end

    def height
        @shape.length
    end

    def width
        @shape[0].length
    end

    def to_s
        l = ""
        @shape.each do |s| 
            l += s.map { |e| e ? "#" : "." }.join 
            l += "\n"
        end
        l
    end
end

class ItemGenerator
    attr_accessor :items, :item_count, :current_item

    def initialize(items)
        @items = items
        @item_count = items.length
        @current_item = 0
    end

    def next_item
        item_index = @current_item % @item_count
        @current_item += 1
        @items[item_index]
    end

    def item_at(index)
        @items[index % @item_count]
    end
end

class Cave
    attr_accessor :width, :rock_generator, :jet_generator, :tower, :tower_height

    def initialize(width, rock_generator, jet_generator)
        @width = width
        @rock_generator = rock_generator
        @jet_generator = jet_generator
        @tower = Array.new(4) { Array.new(7) { false } }
        @tower_height = 0
    end

    def drop
        rock = @rock_generator.next_item
        #puts "new rock"
        place_rock(rock)
        while true
            previous_bottom_index = rock.bottom_index
            step(rock)
            break if rock.bottom_index == previous_bottom_index
        end

        rock_top_index = rock.bottom_index + rock.height - 1
        if rock_top_index + 1 > @tower_height
            @tower_height = rock_top_index + 1
        end
        (0..rock.height-1).each do |i|
            (0..rock.width-1).each do |j|
                next if @tower[rock_top_index-i][rock.left_index+j]
                @tower[rock_top_index-i][rock.left_index+j] = rock.shape[i][j]
            end
        end
    end

    def place_rock(rock)
        rock_bottom_index = @tower_height + 3
        rock_top_index = rock_bottom_index + rock.height - 1
        rock_left_index = 2
        
        need_layers = rock_bottom_index + rock.height - @tower.length
        add_layers(need_layers)
        rock.left_index = rock_left_index
        rock.bottom_index = rock_bottom_index
    end
    
    def step(rock)
        push_rock(rock)
        fall_rock(rock)
    end

    def push_rock(rock)
        jet = @jet_generator.next_item
        rock_top_index = rock.bottom_index + rock.height - 1
        case jet
        when ">"
            rock_right_index = rock.left_index + rock.width - 1
            return if rock_right_index == @width - 1
            can_push = true
            (0..rock.height-1).each do |i|
                (0..rock.width-1).each do |j|
                    rock_fragment = rock.shape[i][j]
                    tower_fragment = @tower[rock_top_index-i][rock.left_index+j+1]
                    if rock_fragment && tower_fragment
                        can_push = false
                        break
                    end
                end
            end
            if can_push
                #puts "push right"
                rock.left_index += 1
            end
        when "<"
            return if rock.left_index == 0
            can_push = true
            (0..rock.height-1).each do |i|
                (0..rock.width-1).each do |j|
                    rock_fragment = rock.shape[i][j]
                    tower_fragment = @tower[rock_top_index-i][rock.left_index+j-1]
                    if rock_fragment && tower_fragment
                        can_push = false
                        break
                    end
                end
            end
            if can_push
                #puts "push left"
                rock.left_index -= 1 
            end
        end
    end

    def fall_rock(rock)
        return if rock.bottom_index == 0

        rock_top_index = rock.bottom_index + rock.height - 1
        can_fall = true
        (0..rock.height-1).each do |i|
            (0..rock.width-1).each do |j|
                rock_fragment = rock.shape[i][j]
                tower_fragment = @tower[rock_top_index-i-1][rock.left_index+j]
                if rock_fragment && tower_fragment
                    can_fall = false
                    break
                end
            end
        end
        if can_fall
            #puts "fall"
            rock.bottom_index -= 1
        end
    end

    def add_layers(count)
        count.times do
            @tower << Array.new(7) { false } 
        end
    end

    def to_s
        l = ""
        @tower.reverse.each do |t| 
            l += t.map { |e| e ? "#" : "." }.join 
            l += "\n"
        end
        l
    end
end

class RockParser
    def parse(input)
        rocks = Array.new
        shape = Array.new
        input.each do |line|
            if line == ""
                rocks << Rock.new(shape)
                shape = Array.new
            else
                shape << line.split("").map { |e| e == "#" }
            end
        end
        rocks
    end
end

rocks_input = File.readlines("rocks.txt", chomp: true)
rocks = RockParser.new.parse(rocks_input)
rock_generator = ItemGenerator.new(rocks)


jets = File.readlines(ARGV[0], chomp: true)[0].split("")
jet_generator = ItemGenerator.new(jets)

cave = Cave.new(7, rock_generator, jet_generator)
ARGV[1].to_i.times do |index|
    if index % 10000 == 0
        puts "dropping #{index}"
    end
    cave.drop
end


puts cave.tower_height