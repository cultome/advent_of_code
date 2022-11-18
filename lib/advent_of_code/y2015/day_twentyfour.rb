require 'set'

def first
  calculate 3
end

def second
  calculate 4
end

def calculate(group_size)
  nums = input

  groups = generate_groups nums.clone, nums.sum / group_size, []

  min = groups.map(&:count).min
  groups.
    select { |g| g.count == min }.
    map { |g| g.reduce(&:*) }.
    min
end

def generate_groups(nums, goal, actual)
  results = []

  while !nums.empty?
    num = nums.pop

    new_total = actual.sum + num
    if new_total == goal
      results << actual + [num]
    elsif new_total < goal
      res = generate_groups nums.clone, goal, actual + [num]
      results.concat(res) unless res&.empty?
    end
  end

  results
end

def input
  open('inputs/y2015/day_twentyfour.txt').map(&:chomp).map(&:to_i)
end
