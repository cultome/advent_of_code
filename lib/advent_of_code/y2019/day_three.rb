def first
  wire1, wire2 = input

  board = run_wire(wire1) { |point, step| step }

  intersections = run_wire(wire2 ) do |point, _|
    next unless board.key? point

    point.split(",").map(&:to_i).map(&:abs).sum
  end

  _, min_steps = intersections.min { |(_,v1), (_,v2)| v1 <=> v2 }

  min_steps
end

def second
  wire1, wire2 = input

  board = run_wire(wire1) { |point, step| step }

  steps = run_wire(wire2 ) { |point, step| (board[point] + step) if board.key? point }

  steps.values.min
end


def run_wire(wire)
  acc = {}
  x, y, step = 0, 0, 0

  wire.split(",").each do |cmd|
    dir, dist = cmd[0], cmd[1..].to_i

    case dir
    when "R"
      dist.times do
        point = "#{x += 1},#{y}"
        step += 1

        res = yield point, step
        acc[point] = res unless res.nil?
      end
    when "U"
      dist.times do
        point = "#{x},#{y += 1}"
        step += 1

        res = yield point, step
        acc[point] = res unless res.nil?
      end
    when "L"
      dist.times do
        point = "#{x -= 1},#{y}"
        step += 1

        res = yield point, step
        acc[point] = res unless res.nil?
      end
    when "D"
      dist.times do
        point = "#{x},#{y -= 1}"
        step += 1

        res = yield point, step
        acc[point] = res unless res.nil?
      end
    end
  end

  acc
end

def input
  File.read('inputs/y2019/day_three.txt').split("\n")
end
