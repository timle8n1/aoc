class Wrapper 
    attr_accessor :value

    def to_s
        value.to_s
    end
end

input = File.readlines(ARGV[0], chomp: true).map(&:to_i)
length = input.length
orginal_list = []
mix_list = []
(0..input.length-1).each do |index|
    w = Wrapper.new
    w.value = input[index]
    orginal_list << w
    mix_list << w
end

orginal_list.each do |w|
    current_index = mix_list.index(w)
    new_index = current_index + w.value % (length - 1)
    mix_list.insert(new_index, w)
    mix_list.delete_at(current_index)
    puts mix_list.join(",")
end

puts mix_list

