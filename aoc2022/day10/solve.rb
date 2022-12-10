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
        if CYCLES_OF_NOTE.include?(self.cycle)
            self.signals.append(self.x * self.cycle)
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
        pixel = (cursor - cpu.x).abs < 2 ? "#" : "."
        self.screen.append(pixel)
    end
end

module Solver
    def self.solve(input, cpu, crt)
        input.each do |line|
            if line == "noop"
                self.tick(crt, cpu, 1)
            else 
                _, value = line.split(" ")
                self.tick(crt, cpu, 2)
                cpu.addx(value.to_i)
            end
        end
        crt
    end

    def self.tick(crt, cpu, ticks)
        ticks.times do 
            crt.draw_pixel(cpu)
            cpu.check_signal
            cpu.tick
        end
    end
end

input = File.readlines(ARGV[0], chomp: true)
cpu = CPU.new
crt = CRT.new
crt = Solver.solve(input, cpu, crt)
puts cpu.signals.reduce(:+)
puts crt.screen.each_slice(40).to_a.map(&:join)
