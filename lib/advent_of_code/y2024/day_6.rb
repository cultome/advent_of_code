def first
  grid = input
  guard_pos = input.find { |_k, v| v[:type] == '^' }.first
  guard_dir = 0 # up, right, down left

  test_loop grid, guard_pos, guard_dir

  grid.values.select { |block| block[:walked] }.size
end

def second
  grid = input
  guard_pos = input.find { |_k, v| v[:type] == '^' }.first
  guard_dir = 0 # up, right, down left
  grid_w = grid.keys.map { |k| k.split(',').first.to_i }.max + 1
  grid_h = grid.keys.map { |k| k.split(',').last.to_i }.max + 1
  obstructions_for_loop = []

  grid_h.times do |y|
    print "Testing #{y + 1} / #{grid_h}     \r"

    grid_w.times do |x|
      next if grid["#{x},#{y}"][:type] == '#'

      g = input
      g["#{x},#{y}"][:type] = '#'

      if test_loop g, guard_pos, guard_dir
        # is a loop
        obstructions_for_loop << "#{x},#{y}"
      end
    end
  end

  obstructions_for_loop.size
end

def input
  x = 0
  y = 0

  open('inputs/y2024/day_6.txt').map(&:chomp).each_with_object({}) do |line, acc|
    line.chars.each do |block|
      acc["#{x},#{y}"] = { type: block, walked: false, dirs: [] }

      x += 1
    end
    y += 1
    x = 0
  end
end

def next_pos(pos, dir)
  x, y = pos.split(',').map(&:to_i)

  case dir
  when 0 # up
    y -= 1
  when 1 # right
    x += 1
  when 2 # down
    y += 1
  when 3 # left
    x -= 1
  end

  "#{x},#{y}"
end

def test_loop(grid, guard_pos, guard_dir)
  loop do
    return true if grid[guard_pos][:walked] && grid[guard_pos][:dirs].include?(guard_dir)

    grid[guard_pos][:walked] = true
    grid[guard_pos][:dirs] << guard_dir

    next_guard_pos = next_pos guard_pos, guard_dir

    if grid[next_guard_pos].nil?
      return false
    elsif grid[next_guard_pos][:type] == '#'
      guard_dir = (guard_dir + 1) % 4
    else
      guard_pos = next_guard_pos
    end
  end

  false
end
