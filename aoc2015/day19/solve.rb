#! /usr/bin/env ruby

input = File.readlines("input.txt", :chomp => true)

replacements = []
input.each do |line|
  replacements << line.split(" => ")
end

medicine = "CRnCaCaCaSiRnBPTiMgArSiRnSiRnMgArSiRnCaFArTiTiBSiThFYCaFArCaCaSiThCaPBSiThSiThCaCaPTiRnPBSiThRnFArArCaCaSiThCaSiThSiRnMgArCaPTiBPRnFArSiThCaSiRnFArBCaSiRnCaPRnFArPMgYCaFArCaPTiTiTiBPBSiThCaPTiBPBSiRnFArBPBSiRnCaFArBPRnSiRnFArRnSiRnBFArCaFArCaCaCaSiThSiThCaCaPBPTiTiRnFArCaPTiBSiAlArPBCaCaCaCaCaSiRnMgArCaSiThFArThCaSiThCaSiRnCaFYCaSiRnFYFArFArCaSiRnFYFArCaSiRnBPMgArSiThPRnFArCaSiRnFArTiRnSiRnFYFArCaSiRnBFArCaSiRnTiMgArSiThCaSiThCaFArPRnFArSiRnFArTiTiTiTiBCaCaSiRnCaCaFYFArSiThCaPTiBPTiBCaSiThSiRnMgArCaF"

results = {}
replacements.each do |replacement|
  offset = 0
  while true
    index = medicine.index(replacement[0], offset)
    break if index == nil
    prefix = medicine[0, index]
    suffix = medicine[index + replacement[0].length...]
    results[prefix + replacement[1] + suffix] = 1
    offset = index + replacement[0].length
  end
end

pp results.count

evolve = "e"

count = 0
while true
  count += 1
  previous = evolve
  
    replacements.each do |replacement|
      offset = 0
      while true
        index = evolve.index(replacement[0], offset)
        break if index == nil
        prefix = evolve[0, index]
        suffix = evolve[index + replacement[0].length...]
        replace = prefix + replacement[1] + suffix
        
        previous = replace if replace.length > previous.length
        break if previous == medicine

        offset = index + replacement[0].length
      end
    end

  break if previous == medicine
  puts previous
  evolve = previous
end
  
puts count