def first
  list = input
  ptr = 0
  steps = 0

  loop do
    next_jump = list[ptr]

    return steps if next_jump.nil?

    list[ptr] += 1
    ptr += next_jump
    steps += 1
  end
end

def second
  list = input
  ptr = 0
  steps = 0

  loop do
    next_jump = list[ptr]

    return steps if next_jump.nil?

    list[ptr] += next_jump >= 3 ? -1 : 1
    ptr += next_jump
    steps += 1
  end
end

def input
  open('inputs/y2017/day_five.txt').map(&:chomp).map(&:to_i)
end
