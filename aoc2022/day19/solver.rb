module Material
    ORE = "ore"
    CLAY = "clay"
    GEODE = "geode"
    OBSIDIAN = "obsidian"
end

RobotPlan = Struct.new(:type, :material_need)
Blueprint = Struct.new(:number, :plans)

class Parser
    def parse(input)
        blueprint_regex = /(\d+?): /

        blueprints = []
        input.each do |line|
            blueprint_number = line.match(blueprint_regex).captures[0]
            plans = line[blueprint_number.length+2..].split(". ")

            robotplans = []
            plans.each do |plan|
                type, makeup = plan.split(":")
                needs = {}
                makeup.split(",").each do |need|
                    need_number, need_type = need.split(" ")
                    needs[need_type] = need_number.to_i
                end
                robotplans << RobotPlan.new(type, needs)
            end
            blueprints << Blueprint.new(blueprint_number.to_i, robotplans)
        end
        blueprints
    end
end

input = File.readlines(ARGV[0], chomp: true)
parser = Parser.new
blueprints = parser.parse(input)

puts blueprints