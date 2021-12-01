def first
  greater = 0

  input.reduce(nil) do |prev, num|
    greater += 1 if !prev.nil? && num > prev

    num
  end

  greater
end

def second
  window = []
  greater  = 0

  input.reduce(nil) do |prev, num|
    window << num
    window.shift if window.size > 3

    greater += 1 if !prev.nil? && window.sum > prev

    window.sum if window.size == 3
  end

  greater
end

def input
  open('inputs/y2021/day_one.txt').map(&:chomp).map(&:to_i)
end
