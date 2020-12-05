def first
  grid = 0.upto(999).map { 0.upto(999).map { false } }

  input.each do |inst|
    inst =~ /^(toggle|turn on|turn off) ([\d]+),([\d]+) through ([\d]+),([\d]+)$/
    op = $1
    x1 = $2.to_i
    y1 = $3.to_i
    x2 = $4.to_i
    y2 = $5.to_i

    x1.upto(x2) do |x|
      y1.upto(y2) do |y|
        grid[y][x] = case op
                     when 'toggle'
                       !grid[y][x]
                     when 'turn on'
                       true
                     when 'turn off'
                       false
                     end
      end
    end
  end

  grid.reduce(0) { |acc, row| acc + row.count { |v| v } }
end

def second
  grid = 0.upto(999).map { 0.upto(999).map { 0 } }

  input.each do |inst|
    inst =~ /^(toggle|turn on|turn off) ([\d]+),([\d]+) through ([\d]+),([\d]+)$/
    op = $1
    x1 = $2.to_i
    y1 = $3.to_i
    x2 = $4.to_i
    y2 = $5.to_i

    x1.upto(x2) do |x|
      y1.upto(y2) do |y|
        grid[y][x] += case op
                      when 'toggle'
                        2
                      when 'turn on'
                        1
                      when 'turn off'
                        -1
                      end
        grid[y][x] = 0 if grid[y][x] < 0
      end
    end
  end

  grid.reduce(0) { |acc, row| acc + row.sum }
end

def input
  open('inputs/y2015/day_six.txt').map(&:chomp)
end
