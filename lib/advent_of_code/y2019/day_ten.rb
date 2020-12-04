def first
  stars = input.flat_map.with_index do |row,idy|
    row.map.with_index { |position, idx| position == "#" ? [idx, idy] : nil}.compact
  end

  results = stars.map do |(x, y)|
    n = calculate_viewsigh_asteroids(x,y, input)
    [[x,y], n]
  end

  best = results.max { |a, b| a[1].size <=> b[1].size }
  best[1].size
end

def second
  cannon = [31, 20]
  stars = input.flat_map.with_index do |row,idy|
    row.map.with_index { |position, idx| position == "#" ? [idx, idy] : nil}.compact
  end

  stars_by_distance = stars
    .map do |star|
    {
      star: star,
      angle: (Math.atan2(cannon[1] - star[1], cannon[0] - star[0]) * 180 / Math::PI - 90).round(2),
      distance: Math.hypot(cannon[0] - star[0], cannon[1] - star[1])
    }
  end.group_by { |a| a[:angle] }.map { |a| a[1].sort_by{ |a| a[:distance] }}.flatten.sort_by { |a| [a[:angle], a[:distance]] }

  idx = stars_by_distance.find_index { |a| a[:angle] == 0} - 1
  destroy_idx = 1
  last_angle = nil

  loop do
    idx = (idx + 1) % stars.size

    break if stars_by_distance.all? { |a| a.has_key? :destroyed }
    next if stars_by_distance[idx].key? :destroyed
    next if stars_by_distance[idx][:angle] == last_angle && stars_by_distance.count { |a| a.has_key? :destroyed } != stars.size-1

    last_angle = stars_by_distance[idx][:angle]
    stars_by_distance[idx][:destroyed] = destroy_idx
    destroy_idx += 1
  end

  n200 = stars_by_distance.find { |a| a[:destroyed] == 200 }

  n200[:star][0] * 100 + n200[:star][1]
end

def calculate_viewsigh_asteroids(x, y, nav)
  height = nav.size
  width = nav.first.size
  asteroids = []

  height.times do |dy|
    width.times do |dx|
      next if [dx, dy] == [x, y]
      next unless nav[dy][dx] == "#"

      coord = normalize_vector(x,y, dx, dy)
      asteroids << coord unless asteroids.include? coord
    end
  end

  asteroids
end

def normalize_vector(x,y, dx,dy)
  if dy - y == 0
    [dx - x < 0 ? -1 : 1, 0]
  else
    rat = Rational(dx - x, dy - y)
    numerator = dx - x < 0 ? rat.numerator.abs * -1 : rat.numerator.abs

    [numerator, dy - y < 0 ? rat.denominator * -1 : rat.denominator]
  end
end

def input
  @input ||= File.read('inputs/y2019/day_ten.txt')
    .split("\n")
    .map(&:chomp)
    .map{ |row| row.split("") }
end
