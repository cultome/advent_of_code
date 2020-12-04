def first
  self.class.disable_prompt = true
  program = File.read("input/five_one.txt").chomp.split(",").map(&:to_i)

  state = execute_intcode(program, version: 2)

  respond state[:last_output]
end

def second
  self.class.disable_prompt = true
  program = File.read("input/five_two.txt").chomp.split(",").map(&:to_i)

  state = execute_intcode(program, version: 2)
  respond state[:last_output]
end

def input
  open('inputs/y2019/day_five.txt').map { |line|  }
end
