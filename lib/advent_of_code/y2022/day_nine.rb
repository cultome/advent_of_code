def move(lead, current, dir, is_tail)
  if lead.nil?
    case dir
    when 'U'
      current[0] += 1
    when 'D'
      current[0] -= 1
    when 'R'
      current[1] += 1
    when 'L'
      current[1] -= 1
    end
  else
    diff = Math.sqrt(
      (current[0] - lead[0])**2 + (current[1] - lead[1])**2
    )

    row_move = (lead[0] - current[0]) / 2.0
    col_move = (lead[1] - current[1]) / 2.0

    if diff >= 2
      current[0] += row_move >= 0 ? row_move.ceil : row_move.floor
      current[1] += col_move >= 0 ? col_move.ceil : col_move.floor

      if is_tail
        @walk << current.clone
      end
    end
  end

  current
end

def first
  @walk = [[0,0]]
  head_pos = [0,0]
  tail_pos = [0,0]

  input.each do |dir, steps|
    steps.times do |step|
      head_pos = move nil, head_pos, dir, false
      tail_pos = move head_pos, tail_pos, dir, true
    end
  end

  @walk.uniq.size
end

def second
  @walk = [[0,0]]
  pos = Array.new(10) { [0,0] }

  input.each do |dir, steps|
    steps.times do
      pos[0] = move nil, pos[0], dir, false

      1.upto(9) do |idx|
        pos[idx] = move pos[idx-1], pos[idx], dir, idx == 9
      end
    end
  end

  @walk.uniq.size
end

def input
  open('inputs/y2022/day_nine.txt')
    .map(&:chomp)
    .map { |line| line.split(' ') }
    .map{ |dir, step| [dir, step.to_i] }
end
