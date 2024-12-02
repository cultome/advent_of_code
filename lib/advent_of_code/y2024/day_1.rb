def first
  a, b = input

  a.zip(b).map { |ma, mb| (ma - mb).abs }.sum
end

def second
  a, b = input

  a.map do |ma|
    ma * b.count(ma)
  end.sum
end

def input
  list_a = []
  list_b = []

  open('inputs/y2024/day_1.txt').map(&:chomp).map do |line|
    a, b = line.split(/\s+/)

    list_a << a.to_i
    list_b << b.to_i
  end

  [list_a.sort, list_b.sort]
end
