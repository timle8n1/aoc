#! /usr/bin/env ruby

module Solver
  Wire = Struct.new(:label, :operator, :inputs)

  OPERATORS = {
    "PASS_THRU" => ->(a) { a },
    "CONSTANT" => ->(c) { c },
    "AND" => ->(a, b) { a & b },
    "OR" => ->(a, b) { a | b },
    "NOT" => ->(a) { ~a },
    "LSHIFT" => ->(a, n) { a << n },
    "RSHIFT" => ->(a, n) { a >> n }
  }

  def self.trace(wire, wires, cache)
    return cache[wire.label] if cache[wire.label]
    return wire.inputs[0].to_i if wire.operator == "CONSTANT"
    
    operation = OPERATORS[wire.operator]
    raise "Unable to handle: #{wire.operator}" if operation == nil

    inputs = []
    if wire.inputs[0].match(/^\d+$/)
      inputs << wire.inputs[0].to_i
    else
      result = trace(wires[wire.inputs[0]], wires, cache).to_i
      result = result & 0xFFFF if result < 0
      inputs << result
    end
    
    if wire.inputs[1]
      if wire.inputs[1].match(/^\d+$/)
        inputs << wire.inputs[1].to_i
      else
        result = trace(wires[wire.inputs[1]], wires, cache).to_i
        result = result & 0xFFFF if result < 0
        inputs << result
      end
    end

    result = operation.call(*inputs)
    cache[wire.label] = result
  end
end

input = File.readlines("input.txt", :chomp => true)

wires = {}

input.each do |instruction|
  (operation, label) = instruction.split(" -> ")
  operands = operation.split(" ")

  wire = nil
  if operands.count == 1
    operand = operands[0]
    if operand.match(/^\d+$/)
      wire = Solver::Wire.new(label, "CONSTANT", [operands[0]])
    else
      wire = Solver::Wire.new(label, "PASS_THRU", [operands[0]])
    end
  elsif operands.count == 2
    wire = Solver::Wire.new(label, operands[0], [operands[1]])
  elsif operands.count == 3
    wire = Solver::Wire.new(label, operands[1], [operands[0], operands[2]])  
  end
  wires[label] = wire
end

result = Solver.trace(wires["a"], wires, {})
pp result

wires["b"].inputs[0] = result
puts Solver.trace(wires["a"], wires, {})
