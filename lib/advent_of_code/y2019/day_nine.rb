require 'advent_of_code/y2019/calculator'

include Calculator

def first
  @relative_base = 0

  state = execute_intcode(input, version: 4)

  state[:last_output]
end

def second
  @relative_base = 0

  state = execute_intcode(input, version: 4)

  state[:last_output]
end

def input
  File.read('inputs/y2019/day_nine.txt').chomp.split(",").map(&:to_i)
end
