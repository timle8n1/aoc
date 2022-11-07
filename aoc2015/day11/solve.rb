#! /usr/bin/env ruby

module Solver
  BANNED = "iol"

  def self.next_valid_password(password)
    while true
      next_password = next_password(password)
      return next_password if is_valid_password(next_password)
      password = next_password
    end
  end

  def self.next_password(password)
    length = password.length
    (0...length).each do |i|
      character = password[length-i-1]
      next_ascii = character.ord + 1
      if next_ascii < 123
        password[length-i-1] = next_ascii.chr
        return password
      else
        password[length-i-1] = "a"
      end
    end
  end

  def self.is_valid_password(password)
    return false if password.count(BANNED) > 0

    pairs = {}
    (0...password.length-1).each do |i|
      if password[i] == password[i+1]
        pairs[password[i]] = 1
      end
    end
    return false unless pairs.keys.count > 1

    has_run = false
    (0...password.length-2).each do |i|
      has_run = password[i].ord+1 == password[i+1].ord && password[i+1].ord+1 == password[i+2].ord
      break if has_run
    end
    return false unless has_run

    true
  end
end

password = "vzbxkghb"
next_password = Solver.next_valid_password(password)
pp next_password
pp Solver.next_valid_password(next_password)