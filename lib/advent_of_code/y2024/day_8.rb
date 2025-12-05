def first
  grid = input
  width = grid.first.size
  height = grid.size
  freqs = grid.flat_map(&:uniq).uniq.reject { |freq| freq == '.' }
  antinodes = []

  freqs.each do |freq|
    # detect pairs
    pairs = []

    grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        pairs << [x, y] if cell == freq
      end
    end

    # calculate antinodes
    pairs.each_with_index do |cpair, idx1|
      pairs.each_with_index do |pair, idx2|
        next if idx1 == idx2

        delta = [cpair[0] - pair[0], cpair[1] - pair[1]]

        next if (cpair[0] + delta[0]).negative? || (cpair[0] + delta[0]) >= width
        next if (cpair[1] + delta[1]).negative? || (cpair[1] + delta[1]) >= height

        antinodes << [cpair[1] + delta[1], cpair[0] + delta[0]]
      end
    end
  end

  antinodes.uniq.size
end

def second
  grid = input
  width = grid.first.size
  height = grid.size
  freqs = grid.flat_map(&:uniq).uniq.reject { |freq| freq == '.' }
  antinodes = []

  freqs.each do |freq|
    # detect pairs
    pairs = []

    grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        pairs << [x, y] if cell == freq
      end
    end

    # calculate antinodes
    pairs.each_with_index do |cpair, idx1|
      pairs.each_with_index do |pair, idx2|
        next if idx1 == idx2

        # down
        delta = o_delta = [pair[0] - cpair[0], pair[1] - cpair[1]]

        loop do
          break if (cpair[0] + delta[0]).negative? || (cpair[0] + delta[0]) >= width
          break if (cpair[1] + delta[1]).negative? || (cpair[1] + delta[1]) >= height

          antinodes << [cpair[1] + delta[1], cpair[0] + delta[0]]

          delta = [delta[0] + o_delta[0], delta[1] + o_delta[1]]
        end

        # up
        delta = o_delta = [cpair[0] - pair[0], cpair[1] - pair[1]]

        loop do
          break if (cpair[0] + delta[0]).negative? || (cpair[0] + delta[0]) >= width
          break if (cpair[1] + delta[1]).negative? || (cpair[1] + delta[1]) >= height

          antinodes << [cpair[1] + delta[1], cpair[0] + delta[0]]

          delta = [delta[0] + o_delta[0], delta[1] + o_delta[1]]
        end
      end
    end
  end

  antinodes.uniq.size
end

def input
  open('inputs/y2024/day_8.txt').map(&:chomp).map(&:chars)
end
