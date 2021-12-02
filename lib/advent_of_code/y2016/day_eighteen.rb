TRAP = '^'
SAFE = '.'

def first
  rows = 40
  prev_row = input
  row_size = prev_row.size
  safe_tiles_count = prev_row.count { |tile| tile == SAFE }
  grid = [prev_row.join]

  (rows - 1).times do
    new_row = []

    row_size.times do |col|
      left = col-1 >= 0 ? prev_row[col-1] : SAFE
      center = prev_row[col]
      right = col+1 < row_size ? prev_row[col+1] : SAFE

      is_trap =
        #Its left and center tiles are traps, but its right tile is not.
        (left == TRAP && center == TRAP && right == SAFE) ||
        #Its center and right tiles are traps, but its left tile is not.
        (left == SAFE && center == TRAP && right == TRAP) ||
        #Only its left tile is a trap.
        (left == TRAP && center == SAFE && right == SAFE) ||
        #Only its right tile is a trap.
        (left == SAFE && center == SAFE && right == TRAP)

      new_row << (is_trap ? TRAP : SAFE)
    end

    safe_tiles_count += new_row.count { |tile| tile == SAFE }
    grid << [new_row.join]
    prev_row = new_row
  end

  safe_tiles_count
end

def second
  rows = 400000
  prev_row = input
  row_size = prev_row.size
  safe_tiles_count = prev_row.count { |tile| tile == SAFE }
  grid = [prev_row.join]

  (rows - 1).times do
    new_row = []

    row_size.times do |col|
      left = col-1 >= 0 ? prev_row[col-1] : SAFE
      center = prev_row[col]
      right = col+1 < row_size ? prev_row[col+1] : SAFE

      is_trap =
        #Its left and center tiles are traps, but its right tile is not.
        (left == TRAP && center == TRAP && right == SAFE) ||
        #Its center and right tiles are traps, but its left tile is not.
        (left == SAFE && center == TRAP && right == TRAP) ||
        #Only its left tile is a trap.
        (left == TRAP && center == SAFE && right == SAFE) ||
        #Only its right tile is a trap.
        (left == SAFE && center == SAFE && right == TRAP)

      new_row << (is_trap ? TRAP : SAFE)
    end

    safe_tiles_count += new_row.count { |tile| tile == SAFE }
    grid << [new_row.join]
    prev_row = new_row
  end

  safe_tiles_count
end

def input
  open('inputs/y2016/day_eighteen.txt').map(&:chomp).flat_map{ |line| line.split('') }
end
