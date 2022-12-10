#! /usr/bin/env ruby
require "set"

class CPU
    CYCLES_OF_NOTE = [20, 60, 100, 140, 180, 220]

    attr_accessor :cycle, :x, :signals

    def initialize
        @cycle = 1
        @x = 1
        @signals = Array.new()
    end

    def tick
        self.cycle += 1
    end

    def addx(offset)
        self.x += offset
    end

    def check_signal
        if CYCLES_OF_NOTE.include?(cycle)
            signals.append(x * cycle)
        end
    end
end

class CRT
    SCREEN_WIDTH = 40

    attr_accessor :screen

    def initialize 
        @screen = Array.new()
    end

    def draw_pixel(cpu)
        screen_offset = cpu.cycle - 1
        cursor = screen_offset - (SCREEN_WIDTH * (screen_offset / SCREEN_WIDTH))
        pixel = (cursor - cpu.x).abs < 2 ? "█" : " "
        screen.append(pixel)
    end
end

class Computer
    attr_accessor :cpu, :crt

    def initialize
        @cpu = CPU.new
        @crt = CRT.new
    end

    def run(program)
        program.each do |instruction|
            if instruction == "noop"
                tick(crt, cpu, 1)
            else 
                _, value = instruction.split(" ")
                tick(crt, cpu, 2)
                cpu.addx(value.to_i)
            end
        end
    end

    def tick(crt, cpu, ticks)
        ticks.times do 
            crt.draw_pixel(cpu)
            cpu.check_signal
            cpu.tick
        end
    end

    def solve_signal
        cpu.signals.reduce(:+)
    end

    def display
        crt.screen.each_slice(40).to_a.map(&:join)
    end
end

input = File.readlines(ARGV[0], chomp: true)
computer = Computer.new
computer.run(input)
puts computer.solve_signal
puts computer.display
