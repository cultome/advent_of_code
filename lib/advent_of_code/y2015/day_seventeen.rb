def first
  res = input
  combs = []

  while !res.empty?
    curr = res.pop
    generate_combinations(res, [curr], combs)
  end

  combs.size
end

def second
  res = input
  combs = []

  while !res.empty?
    curr = res.pop
    generate_combinations(res, [curr], combs)
  end

  containers_used = combs.map(&:size)
  min_containers = containers_used.min
  containers_used.select { |n| n == min_containers }.size
end

def generate_combinations(input, current, results)
  if current.sum == 150
    results << current
    return
  end

  return if input.empty?

  inp1 = input.clone

  while !inp1.empty?
    elem = inp1.pop

    if current.sum + elem <= 150
      generate_combinations(inp1, [*current, elem], results)
    end
  end
end

def input
  open('inputs/y2015/day_seventeen.txt').map(&:chomp).map(&:to_i)
end
