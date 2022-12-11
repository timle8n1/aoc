#! /usr/bin/env ruby
require "set"

class Monkey
    attr_accessor :items, :operator, :operand, :divisor, :target_true, :target_false, :inspected_count

    def initialize(items, operator, operand, divisor, target_true, target_false)
        @items = items
        @operator = operator
        @operand = operand
        @divisor = divisor
        @target_true = target_true
        @target_false = target_false
        @inspected_count = 0
    end

    def turn(worry_control, keep_away)
        until items.empty?
            item = items.shift
            value = operand == "old" ? item : operand.to_i
            item = item.method(operator).call(value)
            item = worry_control.call(item)
            target_monkey_index = item % @divisor == 0 ? target_true : target_false
            keep_away.call(target_monkey_index, item)
            @inspected_count += 1
        end
    end

    def add_item(item)
        items.append(item)
    end
end

class Parser
    def parse(input)
        input.each_slice(7).map { |lines|
            items = lines[1][18..].split(", ").map(&:to_i)
            operator, operand = lines[2][22..].split(" ")
            divisor = lines[3][21..].to_i
            true_monkey = lines[4][29..].to_i
            false_monkey = lines[5][30..].to_i
            Monkey.new(items, operator, operand, divisor, true_monkey, false_monkey)
        }
    end
end

class KeepAway
    attr_accessor :monkeys, :worry_control

    def initialize(monkeys, worry_control)
        @monkeys = monkeys
        @worry_control = worry_control
    end

    def play_round(turns)
        turns.times { play_turn }
    end

    def play_turn
        monkeys.each do |monkey|
            monkey.turn(worry_control, method(:keep_away))
        end
    end

    def keep_away(target_monkey_index, item)
        monkeys[target_monkey_index].add_item(item)
    end

    def score
        monkeys.map(&:inspected_count).sort.reverse.take(2).reduce(1, :*)
    end
end

input = File.readlines(ARGV[0], chomp: true)
parser = Parser.new

monkeys = parser.parse(input)
worry_control = -> (worry_level){ worry_level / 3 }
keep_away = KeepAway.new(monkeys, worry_control)
keep_away.play_round(20)
puts keep_away.score

monkeys = parser.parse(input)
modulo = monkeys.reduce(1) { |acc, m| acc * m.divisor }
worry_control = -> (worry_level){ worry_level % modulo }
keep_away = KeepAway.new(monkeys, worry_control)
keep_away.play_round(10000)
puts keep_away.score

