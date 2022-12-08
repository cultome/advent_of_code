def first
  forest = input

  height = forest.size
  width = forest.first.size

  invisibles = []
  1.upto(height-2) do |y|
    1.upto(width-2) do |x|
      cur = forest[y][x]

      if (0...y).any? { |y1| forest[y1][x] >= cur } &&
          (y+1...height).any? { |y1| forest[y1][x] >= cur } &&
          (0...x).any? { |x1| forest[y][x1] >= cur } &&
          (x+1...width).any? { |x1| forest[y][x1] >= cur }

        invisibles << [y,x]
      end
    end
  end

  width * height - invisibles.size
end

def second
  forest = input

  height = forest.size
  width = forest.first.size

  views = []
  1.upto(height-2) do |y|
    1.upto(width-2) do |x|
      cur = forest[y][x]

      up = (0...y).to_a.reverse.take_while { |y1| forest[y1][x] < cur }
      left = (0...x).to_a.reverse.take_while { |x1| forest[y][x1] < cur }
      down = (y+1...height).take_while { |y1| forest[y1][x] < cur }
      right = (x+1...width).take_while { |x1| forest[y][x1] < cur }

      up.pop if up.include? 0
      left.pop if left.include? 0
      down.pop if down.include? height-1
      right.pop if right.include? width-1

      views << [up.size + 1, down.size + 1, left.size + 1, right.size + 1].reduce(&:*)
    end
  end

  views.max
end

def input
  open('inputs/y2022/day_eight.txt').map(&:chomp).each_with_object([]) do |line, acc|
    acc << line.split('').map(&:to_i)
  end
end
