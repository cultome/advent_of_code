def first
  input.count { |a, b, c| a + b > c && a + c > b && b + c > a }
end

def second
  data = input.flatten

  col1 = data.select.with_index { |n, idx| idx % 3 == 0 }.each_slice(3).count { |a, b, c| a + b > c && a + c > b && b + c > a }
  col2 = data[1..].select.with_index { |n, idx| idx % 3 == 0 }.each_slice(3).count { |a, b, c| a + b > c && a + c > b && b + c > a }
  col3 = data[2..].select.with_index { |n, idx| idx % 3 == 0 }.each_slice(3).count { |a, b, c| a + b > c && a + c > b && b + c > a }

  col1 + col2 + col3
end

def input
  open('inputs/y2016/day_three.txt').map(&:chomp).map { |line| line.split(' ').map(&:to_i) }
end
