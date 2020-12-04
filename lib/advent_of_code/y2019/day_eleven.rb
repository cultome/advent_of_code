require 'advent_of_code/y2019/calculator'

include Calculator

def first
  _, tiles = robot_walk input
  tiles.size
end

def second
  white = 1

  grid, _ = robot_walk input, white

  heights = grid.keys.sort
  widths = grid.values.flat_map(&:keys).sort

  hmin, hmax = heights.first, heights.last
  wmin, wmax = widths.first, widths.last

  checksum = print_message grid, hmax, hmin, wmax, wmin

  checksum.join
end

def robot_walk(program, initial_color=0)
  black = 0
  move_left = 0
  #move_right = 1
  face_up = 0
  face_left= 1
  face_down = 2
  face_right = 3

  grid = Hash.new { |h,k| h[k] = Hash.new { |h2, k2| h2[k2] = black }}
  x, y, facing = 0, 0, 0

  state = {version: 3, read_from: :read_buffer}
  @relative_base = 0
  @input_buffer = [initial_color]
  tiles = Set.new

  loop do
    break if state[:terminated]

    state = execute_intcode(program, **state)
    color = state[:last_output]

    grid[y][x] = color
    tiles.add "(#{x}, #{y})"

    state = execute_intcode(program, **state)
    move = state[:last_output]

    case facing
    when face_up
      x, y, facing = move == move_left ? [x-1, y, face_left] : [x+1, y, face_right]
    when face_left
      x, y, facing = move == move_left ? [x, y-1, face_down] : [x, y+1, face_up]
    when face_down
      x, y, facing = move == move_left ? [x+1, y, face_right] : [x-1, y, face_left]
    when face_right
      x, y, facing = move == move_left ? [x, y+1, face_up] : [x, y-1, face_down]
    end

    @input_buffer.push grid[y][x]
  end

  [grid, tiles]
end

def print_message(grid, hmax, hmin, wmax, wmin)
  black = 0
  white = 1

  checksum = []
  hmax.downto(hmin) do |y|
    row = []
    wmin.upto(wmax) do |x|
      checksum << grid.fetch(y, {}).fetch(x, black)
      row << (grid.fetch(y, {}).fetch(x, black) == white ? "#" : " ")
    end
    #logger.info "#{row.join}"
  end

  checksum
end

def input
  File.read('inputs/y2019/day_eleven.txt').chomp.split(",").map(&:to_i)
end
