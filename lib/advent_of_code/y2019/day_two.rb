require 'advent_of_code/y2019/calculator'

include Calculator

def first
  # restore state
  input[1..2] = 12, 2

  state = execute_intcode input
  state[:last_output]
end

def second
  noun, verb = ((0..99).to_a.product (0..99).to_a).find do |noun, verb|
    tmp_program = input.clone
    # restore state
    tmp_program[1..2] = noun, verb

    state = execute_intcode(tmp_program)
    state[:last_output] == 19690720
  end

  "#{noun.to_s.rjust(2, "0")}#{verb.to_s.rjust(2, "0")}"
end

def input
  @input ||= File.read('inputs/y2019/day_two.txt').chomp.split(",").map(&:to_i)
end
