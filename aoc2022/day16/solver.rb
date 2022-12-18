class Valve
    attr_accessor :name, :rate, :tunnels, :open, :open_since

    def initialize(name, rate, tunnels)
        @name = name
        @rate = rate
        @tunnels = tunnels
        @open = false
        @open_since = nil
    end

    def to_s
        "#{@name} #{@rate} #{@open} #{@open_since}"
    end
end

class Parser
    def parse(input)
        valve_map = {}
        input.each do |line|
            valve_rate, tunnel_list = line.split(";")
            valve, rate = valve_rate.split("=")
            rate = rate.to_i
            tunnels = tunnel_list.split(",")
            valve_map[valve] = Valve.new(valve, rate, tunnels)
        end
        valve_map
    end
end

class RewardOptimizer
    attr_accessor :valve_map, :distance_cache

    def initialize(valve_map, distance_cache)
        @valve_map = valve_map
        @distance_cache = distance_cache
    end

    def find_rewards(start_node, need_visited, total_rewards, total_cost, max_cost)
        visit = need_visited.clone
        visit.delete(start_node.name)

        if visit.empty?
            return [total_rewards]
        end

        rewards = []
        visit.each do |next_key|
            target_valve = @valve_map[next_key]

            key = start_node.name+target_valve.name
            new_cost = @distance_cache[key] + 1
            new_total_cost = new_cost + total_cost
            next if new_total_cost > max_cost

            reward = target_valve.rate * (max_cost - new_total_cost)

            rewards << find_rewards(target_valve, visit, total_rewards+reward, new_total_cost, max_cost)
        end
        if rewards.empty?
            return [total_rewards]
        end
        rewards.sort.max
    end
end

class DistanceCache
    attr_accessor :valve_map, :distance_cache

    def initialize(valve_map)
        @valve_map = valve_map
        @distance_cache = {}
    end

    def precompute
        valve_map.keys.each do |k|
            valve = valve_map[k]
            valve.tunnels.each do |t|
                next if @distance_cache[k+t]
                next if @distance_cache[t+k]

                @distance_cache[k+t] = 1
                @distance_cache[t+k] = 1
            end
        end

        valve_map.keys.each do |k1|
            valve_map.keys.each do |k2|
                next if k1 == k2
                next if @distance_cache[k1+k2]
                target_valve = valve_map[k1]
                current_valve = valve_map[k2]
                visits = recurse_distance([], current_valve, target_valve)
                @distance_cache[k1+k2] = visits.length
                @distance_cache[k2+k1] = visits.length
            end
        end
    end

    def recurse_distance(visited, current_valve, target_valve)
        if current_valve.name == target_valve.name
            return visited
        end

        visits = []
        new_visited = visited.clone << current_valve
        current_valve.tunnels.each do |t|
            tunnel = @valve_map[t]
            next if visited.include?(tunnel)
            visits << recurse_distance(new_visited, tunnel, target_valve)
        end
        visits.reject{ |v| v == nil}.sort_by{ |v| v.length }.first
    end
end

input = File.readlines(ARGV[0], chomp: true)
parser = Parser.new
valve_map = parser.parse(input)

dc = DistanceCache.new(valve_map)
dc.precompute

optimizer = RewardOptimizer.new(valve_map, dc.distance_cache)

start_node = valve_map["AA"]
need_visited = valve_map.keys.reject { |k| valve_map[k].rate == 0 }

reward = optimizer.find_rewards(start_node, need_visited, 0, 0, 30)
puts reward
