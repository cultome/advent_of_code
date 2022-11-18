def first
  # The fourth floor contains nothing relevant.
  # The third floor contains a thulium-compatible microchip.
  # The second floor contains a thulium generator, a ruthenium generator, a ruthenium-compatible microchip, a curium generator, and a curium-compatible microchip.
  # The first floor contains a strontium generator, a strontium-compatible microchip, a plutonium generator, and a plutonium-compatible microchip.

  # floors = [
  # [                            ],
  # ['1M'                        ],
  # ['1G', '2G', '2M', '3G', '3M'],
  # ['4G', '4M', '5G', '5M'      ],
  # ].reverse

  # The fourth floor contains nothing relevant.
  # The third floor contains a lithium generator.
  # The second floor contains a hydrogen generator.
  # The first floor contains a hydrogen-compatible microchip and a lithium-compatible microchip.
  floors = [
    [],
    ['LG'],
    ['HG'],
    ['HM', 'LM'],
  ].reverse

  curr_floor = 0

  loop do
    moves = generate_moves curr_floor, floors, curr_floor + 1
    moves.first.each do |x|
      floors[curr_floor].delete x
      floors[curr_floor + 1] << x
    end
    curr_floor += 1
  end
end

def generate_moves(curr_floor, floors, next_floor)
  curr_floor_moves = generate_floor_moves curr_floor, floors

  curr_floor_moves.select do |xs|
    valid? floors[next_floor] + xs
  end
end

def generate_floor_moves(curr_floor, floors)
  floor_xs = floors[curr_floor]
  combos = floor_xs.combination(2).to_a + floor_xs.map { |x| [x] }

  combos.select do |xs|
    still_valid? xs, floor_xs
  end
end

def still_valid?(xs, floor_xs)
  xs_left = floor_xs - xs
  valid? xs_left
end

def valid?(xs)
  xs.all? do |x|
    left2 = xs - [x]

    x[1] == 'G' || left2.none? { |y| y[1] == 'G' } || left2.any? { |y| y[0] == x[0] }
  end
end

def secure?(curr_floor, floors, a, b = nil)
end

def second
  "second part"
end
