def first
  grid_size = 100
  grid = initial_grid grid_size

  100.times do
    grid = next_state grid, grid_size
  end

  grid.flatten.count { |c| c == '#' }
end

def second
  grid_size = 100
  grid = initial_grid grid_size
  # turn on the lights
  grid[1][1] = '#'
  grid[1][grid_size] = '#'
  grid[grid_size][1] = '#'
  grid[grid_size][grid_size] = '#'

  100.times do
    grid = next_state grid, grid_size, 2
  end

  grid.flatten.count { |c| c == '#' }
end

def next_state(grid, size, version = 1)
  new_grid = clean_grid size
  keep_on_cond = [2, 3]
  always_on = [
    "1,1",
    "1,#{size}",
    "#{size},1",
    "#{size},#{size}",
  ]

  1.upto(size).each do |y|
    1.upto(size).each do |x|
      on_count = [
        grid[y + 1][x - 1],
        grid[y + 1][x],
        grid[y + 1][x + 1],
        grid[y - 1][x - 1],
        grid[y - 1][x],
        grid[y - 1][x + 1],
        grid[y][x + 1],
        grid[y][x - 1],
      ].count { |cell| cell == '#' }

      if version == 2 && always_on.include?("#{y},#{x}")
        new_grid[y][x] = '#'
      elsif grid[y][x] == '#' && !keep_on_cond.include?(on_count)
        new_grid[y][x] = '.'
      elsif grid[y][x] == '.' && on_count == 3
        new_grid[y][x] = '#'
      else
        new_grid[y][x] = grid[y][x]
      end
    end
  end

  new_grid
end

def clean_grid(size)
  (size + 2).times.map { ['.'] * (size + 2) }
end

def initial_grid(size)
  grid = input.map { |row| ['.', *row, '.'] }
  grid.unshift(['.'] * (size + 2))
  grid.push(['.'] * (size + 2))

  grid
end

def input
  open('inputs/y2015/day_eightteen.txt').map(&:chomp).map { |line| line.split('') }
end
