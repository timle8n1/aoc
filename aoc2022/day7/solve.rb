#! /usr/bin/env ruby

class Dir
    attr_accessor :name, :files, :sub_dirs, :parent

    def initialize (name, parent)
        @name = name
        @files = Array.new
        @sub_dirs = Array.new
        @parent = parent
    end

    def size
        file_size = @files.reduce(0) { |acc, c| acc += c.size }
        dir_size = @sub_dirs.reduce(0) { |acc, d| acc += d.size }
        file_size + dir_size
    end

    def solve_size
        if size <= 100000
            return size
        end
        return 0
    end

    def pretty_print(prefix)
        result = "#{prefix}- #{name} (dir)"
        @files.sort_by {|f| f.name}.each do |f|
            result += "\n"
            result += "#{prefix}\t- #{f.name} (file, size=#{f.size})"
        end
        @sub_dirs.sort_by {|d| d.name}.each do |d|
            result += "\n"
            result += d.pretty_print(prefix + "\t")
        end
        return result
    end

    def to_s
        pretty_print("")
    end
end

class File 
    attr_accessor :name, :size

    def initialize (name, size)
        @name = name
        @size = size
    end
end

module Solver
    def self.parse_input(input)
        current_dir = Dir.new("/", nil)
        dirs = Array.new
        dirs.append(current_dir)

        input.each do |line|
            if line.start_with?("$")
                _, command, arg = line.split(" ")
                if command == "cd"
                    if arg == ".."
                        current_dir = current_dir.parent
                    else
                        dir = Dir.new(arg, current_dir)
                        dirs.append(dir)
                        current_dir.sub_dirs.append(dir)
                        current_dir = dir
                    end
                end
            else
                next if line.start_with?("dir")
                size, file_name = line.split(" ")
                file = File.new(file_name, size.to_i)
                current_dir.files.append(file)
            end
        end
        dirs
    end

    def self.solve1(dirs)
        return dirs.reduce(0)  { |acc, d| acc += d.solve_size }
    end

    def self.solve2(dirs)
        disk_size = 70000000
        update_size = 30000000

        free_size = disk_size - dirs[0].size
        need_size = update_size - free_size
        dirs.select { |dir| dir.size >= need_size }.sort_by {|dir| dir.size}[0].size
    end
end

input = File.readlines(ARGV[0])
dirs = Solver.parse_input(input)
puts dirs[0]
puts Solver.solve1(dirs)
puts Solver.solve2(dirs)
