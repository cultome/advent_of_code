class Numeric
  def calculate_fuel
    (self / 3.0).floor - 2
  end
end

def first
  input.sum(&:calculate_fuel)
end

def second
  input.reduce(0.0) do |acc, num|
    fuel = num.calculate_fuel

    loop do
      acc += fuel

      fuel = fuel.calculate_fuel

      break if fuel <= 0
    end

    acc
  end
end

def input
  open('inputs/y2019/day_one.txt').map(&:to_f)
end
