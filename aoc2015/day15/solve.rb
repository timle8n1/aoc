#! /usr/bin/env ruby

Ingredient = Struct.new(:name, :capacity, :durability, :flavor, :texture, :calories)

input = File.readlines("input.txt", :chomp => true)

ingredients = []
input.each do |line|
  name, values = line.split(": ")
  results = values.split(", ")

  ingredient = Ingredient.new(name, 0, 0, 0, 0, 0)
  results.each do |result|
    property, value = result.split(" ")
    ingredient.send("#{property}=", value.to_i)
  end

  ingredients << ingredient
end

max = 0
max_500 = 0

(1..100-ingredients.count).each do |i|
  (1..100-ingredients.count).each do |j|
    (1..100-ingredients.count).each do |k|
      (1..100-ingredients.count).each do |l|
        next unless i+j+k+l == 100

        calories = (i*ingredients[0].calories) + (j*ingredients[1].calories) + (k*ingredients[2].calories) + (l*ingredients[3].calories)
        
        capacity = (i*ingredients[0].capacity) + (j*ingredients[1].capacity) + (k*ingredients[2].capacity) + (l*ingredients[3].capacity)
        durability = (i*ingredients[0].durability) + (j*ingredients[1].durability) + (k*ingredients[2].durability) + (l*ingredients[3].durability)
        flavor = (i*ingredients[0].flavor) + (j*ingredients[1].flavor) + (k*ingredients[2].flavor) + (l*ingredients[3].flavor)
        texture = (i*ingredients[0].texture) + (j*ingredients[1].texture) + (k*ingredients[2].texture) + (l*ingredients[3].texture)

        score = [capacity, 0].max * [durability, 0].max * [flavor, 0].max * [texture, 0].max

        max = score if score > max
        next unless calories ==  500
        max_500 = score if score > max_500
      end
    end
  end
end

puts max
puts max_500