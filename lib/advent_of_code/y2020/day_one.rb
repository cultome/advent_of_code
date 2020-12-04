def first
  answer 2
end

def second
  answer 3
end

def answer(size)
  open('inputs/y2020/day_one.txt')
    .map(&:to_i)
    .combination(size)
    .lazy
    .find { |arr| arr.sum == 2020 }
    .reduce(&:*)
end
