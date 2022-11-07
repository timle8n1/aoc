#! /usr/bin/env ruby

Sue = Struct.new(:name, :children, :cats, :samoyeds, :pomeranians, :akitas, :vizslas, :goldfish, :trees, :cars, :perfumes)

input = File.readlines("input.txt", :chomp => true)

facts = {}
facts["children"] = 3
facts["cats"] = 7
facts["samoyeds"] = 2
facts["pomeranians"] = 3
facts["akitas"] = 0
facts["vizslas"] = 0
facts["goldfish"] = 5
facts["trees"] = 3
facts["cars"] = 2
facts["perfumes"] = 1

sues = []

#Sue 1: goldfish: 6, trees: 9, akitas: 0
input.each do |sue|
  first_colon = sue.index(":")
  name = sue[0...first_colon]
  asue = Sue.new(name, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)

  data = sue[first_colon+2..-1]
  props = data.split(", ")
  props.each do |prop|
    k, v = prop.split(": ")
    asue.send("#{k}=", v.to_i)
  end

  sues << asue
end

first_sues = sues.clone
facts.each do |k, v|
  first_sues = first_sues.select do |sue| 
    sv = sue.send(k)
    sv == nil || sv == v
  end
end

puts first_sues[0].name.split(" ")[1]

facts.each do |k, v|
  sues = sues.select do |sue| 
    sv = sue.send(k)
    if k == "cats" || k == "trees"
      sv == nil || sv > v
    elsif k == "pomeranians" || k == "goldfish"
      sv == nil || sv < v
    else
      sv == nil || sv == v
    end
  end
end

puts sues[0].name.split(" ")[1]
