class Array
  def calculate
    input = open('inputs/y2020/day_three.txt').map &:chomp
    x, y, tree_count = 0, 0, 0

    loop do
      return tree_count if input[y].nil?

      input[y] += input[y] while input[y].size <= x

      tree_count += 1 if input[y][x] == "#"

      x, y = x + first, y + last
    end
  end
end

def first
  [3, 1].calculate
end

def second
  [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].map(&:calculate).reduce(&:*)
end
