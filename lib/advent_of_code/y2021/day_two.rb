def first
  pos = [0, 0]

  input.each do |dir, amt|
    case dir
    when 'forward'
      pos[0] += amt
    when 'down'
      pos[1] += amt
    when 'up'
      pos[1] -= amt
    end
  end

  pos.reduce(&:*)
end

def second
  pos = [0, 0, 0]

  input.each do |dir, amt|
    case dir
    when 'forward'
      pos[1] += pos[2] * amt
      pos[0] += amt
    when 'down'
      pos[2] += amt
    when 'up'
      pos[2] -= amt
    end
  end

  pos[0..1].reduce(&:*)
end

def input
  open('inputs/y2021/day_two.txt').map(&:chomp).map do |line|
    dir, amt = line.split(' ')
    [dir, amt.to_i]
  end
end
