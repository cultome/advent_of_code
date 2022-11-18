require 'set'

def first
  x, y = 0, 0

  res = Set.new(['0,0'])

  input.each_with_object(res) do |step, acc|
    case step
    when '^'
      y += 1
    when '>'
      x += 1
    when 'v'
      y -= 1
    when '<'
      x -= 1
    end

    acc.add "#{x},#{y}"
  end.size
end

def second
  x, xr, y, yr = 0, 0, 0, 0
  is_robo = false

  res = Set.new(['0,0'])

  input.each_with_object(res) do |step, acc|
    case step
    when '^'
      is_robo ? yr += 1 : y += 1
    when '>'
      is_robo ? xr += 1 : x += 1
    when 'v'
      is_robo ? yr -= 1 : y -= 1
    when '<'
      is_robo ? xr -= 1 : x -= 1
    end

    if is_robo
      acc.add "#{xr},#{yr}"
    else
      acc.add "#{x},#{y}"
    end

    is_robo = !is_robo
  end.size
end

def input
  File.read('inputs/y2015/day_three.txt').chomp.split('')
end
