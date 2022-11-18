def first
  steps.last.map(&:abs).sum
end

def second
  given_steps = Set.new(['0,0'])
  x, y = 0, 0

  steps.each do |stp|
    segment_x = if stp.first - x < 0
                  (x - 1).downto(stp.first).map { |xs| [xs, y] }
                else
                  (x + 1).upto(stp.first).map { |xs| [xs, y] }
                end

    segment_y = if stp.last - y < 0
                  (y - 1).downto(stp.last).map { |ys| [x, ys] }
                else
                  (y + 1).upto(stp.last).map { |ys| [x, ys] }
                end

    x, y = stp

    segment_x.concat(segment_y).each do |seg|
      return seg.map(&:abs).sum if given_steps.include? seg.join(',')

      given_steps.add seg.join(',')
    end
  end
end

def steps
  x, y = 0, 0
  facing = 'N'

  input.map do |dir, dist|
    case facing
    when 'N'
      if dir == 'R'
        facing = 'E'
        x += dist
      else
        facing = 'O'
        x -= dist
      end
    when 'E'
      if dir == 'R'
        facing = 'S'
        y -= dist
      else
        facing = 'N'
        y += dist
      end
    when 'S'
      if dir == 'R'
        facing = 'O'
        x -= dist
      else
        facing = 'E'
        x += dist
      end
    when 'O'
      if dir == 'R'
        facing = 'N'
        y += dist
      else
        facing = 'S'
        y -= dist
      end
    end

    [x, y]
  end
end

def input
  File.read('inputs/y2016/day_one.txt').chomp.split(', ').map { |step| [step[0], step[1..].to_i] }
end
