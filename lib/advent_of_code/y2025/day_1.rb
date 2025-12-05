def first
  dial = 50
  zero_counts = 0

  input.each do |direction, count|
    dial = if direction == 'R'
      (dial + count) % 100
    else
      (dial + 100 - count) % 100
    end

    zero_counts += 1 if dial == 0
  end

  zero_counts
end

def second
  dial = 50
  zero_counts = 0

  input.each do |direction, count|
    if direction == 'R'
      count.times do |idx|
        zero_counts += 1 if (dial + idx) % 100 == 0
      end

      dial = (dial + count) % 100
    else
      offset = 0
      count.times do |idx|
        if (dial + offset - idx) % 100 == 0
          zero_counts += 1 
          offset += 100
        end
      end

      dial = (dial + offset - count) % 100
    end
  end

  zero_counts
end

def input
  open('inputs/y2025/day_1.txt').map(&:chomp).map { |line| [line[0], line[1..].to_i] }
end
