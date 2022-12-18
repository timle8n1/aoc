require "set"

class Parser
    def parse(input)
        faces = []
        faces_hash = Hash.new(0)
        
        input.each do |cube|
            x, y, z = cube.split(",").map { |e| e.to_i * 10 }
           
            xPlus = [x+5, y, z]
            xMinus = [x-5, y, z]
            yPlus = [x, y+5, z]
            yMinus = [x, y-5, z]
            zPlus = [x, y, z+5]
            zMinus = [x, y, z-5]

            cube_faces = [xPlus, xMinus, yPlus, yMinus, zPlus, zMinus]
            faces.push(*cube_faces)
            cube_faces.each do |f|
                faces_hash[f] = faces_hash[f] + 1
            end
        end
        
        [faces, faces_hash]
    end
end

input = File.readlines(ARGV[0], chomp: true)
parser = Parser.new
faces, faces_hash = parser.parse(input)
puts faces.count
puts faces_hash.values.reject { |v| v > 1}.count