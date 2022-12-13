require 'json'

class NilClass
    def is_ordered?(rhs)
        return 1
    end
end

class Integer
    def wrap
        Array.new(1) {self}
    end

    def is_ordered?(rhs)
        return -1 if rhs.nil?
        if rhs.instance_of? Array
            return self.wrap.is_ordered?(rhs)
        end
        rhs <=> self
    end
end

class Array
    def wrap
        self
    end

    def is_ordered?(rhs)
        return -1 if rhs.nil?
        if rhs.instance_of? Integer
            return self.is_ordered?(rhs.wrap)
        end
        while true
            left_element = self.shift
            right_element = rhs.shift
            return 0 if left_element.nil? && right_element.nil?

            result = left_element.is_ordered?(right_element)
            return result if result != 0 
        end
    end
end

class Element
    attr_accessor :line

    def initialize(line)
        @line = line
    end

    def <=>(rhs)
        left = JSON.parse @line
        right = JSON.parse rhs.line
        left.is_ordered?(right)
    end
end

class Parser
    attr_accessor :elements

    def parse(input)
        @elements = []
        input.each do |line|
            if line.length == 0
                next
            end
            elements << Element.new(line)
        end
    end
end

input = File.readlines(ARGV[0], chomp: true)
parser = Parser.new
parser.parse(input)

puts parser.elements.each_slice(2).each_with_index.reduce(0) { |memo, (elements, index)|
    (elements[0] <=> elements[1]) == 1 ? memo + index + 1 : memo
}

markers = ["[[2]]", "[[6]]"]
parser.elements << Element.new(markers[0])
parser.elements << Element.new(markers[1])

puts parser.elements.sort.reverse.each_with_index.reduce(1) { |memo, (element, index)|
    markers.include?(element.line) ? memo * (index + 1) : memo
}   
