def first
  width = 50
  height = 6
  display = Array.new(height) { Array.new(width) { ' ' } }

  input.each do |cmd, arg1, arg2|
    send cmd, arg1, arg2, display
  end

  display.map { |row| row.count { |letter| letter == '#' } }.sum
end

def second
  width = 50
  height = 6
  display = Array.new(height) { Array.new(width) { ' ' } }

  input.each do |cmd, arg1, arg2|
    send cmd, arg1, arg2, display
  end

  display.each { |d| puts d.join }

  "EFEYKFRFIJ"
end

def rotate_column(col, offset, display)
  display_height = display.size
  col_data = []

  display_height.times do |y|
    col_data << display[y][col]
  end

  offseted_data = col_data.pop(offset)
  col_data.unshift(*offseted_data)

  display_height.times do |y|
    display[y][col] = col_data[y]
  end
end

def rotate_row(row, offset, display)
  display_width = display.first.size
  row_data = display[row]

  offseted_data = row_data.pop(offset)
  row_data.unshift(*offseted_data)
  display[row] = row_data
end

def rect(cols, rows, display)
  rows.times do |y|
    cols.times do |x|
      display[y][x] = '#'
    end
  end
end

def input
  open('inputs/y2016/day_eight.txt').map(&:chomp).map do |line|
    if line =~ /rect ([\d]+)x([\d]+)/
      [:rect, $1.to_i, $2.to_i]
    elsif line =~ /rotate row y=([\d]+) by ([\d]+)/
      [:rotate_row, $1.to_i, $2.to_i]
    elsif line =~ /rotate column x=([\d]+) by ([\d]+)/
      [:rotate_column, $1.to_i, $2.to_i]
    else
      raise "Unable to parse command"
    end
  end
end
