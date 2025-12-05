def first
  sum = 0

  input.each do |num|
    next unless num.size.even?

    mid = num.size / 2

    sum += num.to_i if num[0...mid] == num[mid..]
  end

  sum
end

def second
  sum = 0

  input.each do |num|
    mid = num.size / 2
    mid.downto(1) do |size|
      pattern = num[0...size]

      if num.match? /^#{pattern}(#{pattern})+$/
        sum += num.to_i 

        break
      end
    end
  end

  sum
end

def input
  open('inputs/y2025/day_2.txt')
    .map(&:chomp)
    .first
    .split(',')
    .map { |range| range.split('-') }
    .flat_map { |low, high| (low.to_i..high.to_i).to_a }
    .map(&:to_s)
end
