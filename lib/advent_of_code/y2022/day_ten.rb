def first
  frames = full_frames

  [20, 60, 100, 140, 180, 220].map { |val| frames[val] * val }.sum
end

def second
  lines = full_frames.map do |cycle, x|
    (x-1..x+1).include?((cycle-1) % 40) ? '#' : ' '
  end

  lines
    .group_by
    .with_index { |_, idx| idx / 40 }
    .values
    .map(&:join)
    .join("\n")
    .prepend("\n") # for presentation
end

def full_frames
  cycle = 1
  x = 1
  frames = {}

  input.each do |cmd, param|
    case cmd
    when 'noop'
      cycle += 1
    when 'addx'
      frames[cycle] = x

      cycle += 2
      x += param.to_i
      frames[cycle] = x
    end
  end

  # fill holes for simplicity
  last_val = 1
  1.upto(60*4) do |idx|
    if frames.key? idx
      last_val = frames[idx]
    else
      frames[idx] = last_val
    end
  end

  Hash[frames.sort]
end

def input
  open('inputs/y2022/day_ten.txt').map(&:chomp).map{ |line| line.split(' ') }
end
