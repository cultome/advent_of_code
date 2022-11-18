def first
  ids.max
end

def second
  idx = ids.size.times.find { |idx| ids[idx] + 1 != ids[idx + 1] }

  ids[idx] + 1
end

def walk_tree(way, initial_range, low_sign, up_sign)
  range = initial_range

  way.each do |rc|
    cut = ((range.last - range.first) / 2.0).ceil

    case rc
    when up_sign
      range = (range.first + cut..range.last)
    when low_sign
      range = (range.first..range.last - cut)
    end
  end

  range.first
end

def ids
  @ids ||= input.map do |line|
    row = walk_tree line[0..7], (0..127), 'F', 'B'
    col = walk_tree line[7..], (0..7), 'L', 'R'

    row * 8 + col
  end.sort
end

def input
  open('inputs/y2020/day_five.txt').map(&:chomp).map { |line| line.split('') }
end
