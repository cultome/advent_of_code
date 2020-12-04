require 'advent_of_code/y2019/calculator'

include Calculator

def first
  state = execute_intcode(input, version: 2)

  state[:last_output]
end

def second
  state = execute_intcode(input, version: 2)
  state[:last_output]
end

def input
  File.read('inputs/y2019/day_five.txt').chomp.split(",").map(&:to_i)
end
