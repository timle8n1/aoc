#! /usr/bin/env ruby
require 'digest'

input = "yzbqklnj"

count = 1
md5 = Digest::MD5.new 

while true
  md5.reset
  md5 << "#{input}#{count}"
  hex = md5.hexdigest
  
  if hex.start_with?("00000")
    puts hex
    puts count
  end

  if hex.start_with?("000000")
    puts hex
    puts count
    break
  end
  
  count += 1
end
