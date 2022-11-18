def first
  spiral do |num, x, y|
    num == 347991
  end.map(&:abs).sum
end

def second
  mem = { "(0,0)" => 1 }

  x, y = spiral do |num, x, y|
    mem["(#{x},#{y})"] =
      mem.fetch("(#{x - 1},#{y - 1})", 0) +
      mem.fetch("(#{x},#{y - 1})", 0) +
      mem.fetch("(#{x + 1},#{y - 1})", 0) +
      mem.fetch("(#{x - 1},#{y})", 0) +
      mem.fetch("(#{x + 1},#{y})", 0) +
      mem.fetch("(#{x - 1},#{y + 1})", 0) +
      mem.fetch("(#{x},#{y + 1})", 0) +
      mem.fetch("(#{x + 1},#{y + 1})", 0)

    mem["(#{x},#{y})"] >= 347991
  end

  mem["(#{x},#{y})"]
end

def spiral
  directions = %i[right up left down]
  dir = 0
  x, y = 0, 0
  mem = { "(0,0)" => 1 }
  steps = 1
  current_steps = 0
  current_segment = 1
  num = 0

  loop do
    num += 1

    case directions[dir]
    when :right
      x += 1
    when :left
      x -= 1
    when :up
      y -= 1
    when :down
      y += 1
    end

    return [x, y] if yield(num + 1, x, y)

    current_steps += 1

    if current_steps % steps == 0
      dir = (dir + 1) % directions.size
      current_steps = 0
      current_segment += 1
    end

    if current_segment % 3 == 0
      current_segment = 1
      steps += 1
    end
  end
end
