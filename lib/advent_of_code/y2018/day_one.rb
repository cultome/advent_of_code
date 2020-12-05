require 'set'

def first
  input.reduce(0) { |acc, n| acc + n }
end

def second
  acc = 0
  detected = Set.new([0])

  loop do
    freqs = input.map { |n| acc += n }

    freqs.each do |freq|
      return freq if detected.include?(freq)

      detected.add freq
    end
  end
end

def input
  open('inputs/y2018/day_one.txt').map(&:chomp).map(&:to_i)
end
