def first
  input.map do |row|
    row.max - row.min
  end.sum.to_i
end

def second
  input.map do |row|
    row
      .combination(2)
      .map { |arr| arr.sort.reverse }
      .find { |a, b| a % b == 0 }
      .reduce(&:/)
  end.sum.to_i
end

def input
  open('inputs/y2017/day_two.txt').map(&:chomp).map do |row|
    row.split(' ').map(&:to_f)
  end
end
