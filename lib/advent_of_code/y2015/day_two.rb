def first
  input.reduce(0) do |acc, inst|
    l, w, h = inst.split('x').map(&:to_i)

    acc + (2*l*w + 2*w*h + 2*h*l) + [l * h, l * w, h * w].min
  end
end

def second
  input.reduce(0) do |acc, inst|
    l, w, h = inst.split('x').map(&:to_i)

    acc + (l * w * h) + [l*2 + w*2, l*2 + h*2, h*2 + w*2].min
  end
end

def input
  open('inputs/y2015/day_two.txt').map(&:chomp)
end
