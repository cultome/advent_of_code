def first
  value = input.first
  40.times { value = process value }
  value.size
end

def second
  value = input.first
  50.times { value = process value }
  value.size
end

def process(value)
  segments = value.split('').slice_when { |a, b| a != b }.map(&:join)
  value = segments.map do |seg|
    "#{seg.size}#{seg[0]}"
  end.join()
end

def input
  open('inputs/y2015/day_ten.txt').map(&:chomp)
end
