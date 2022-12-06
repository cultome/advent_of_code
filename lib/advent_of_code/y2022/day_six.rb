def first
  detect_distinct_chars 4
end

def second
  detect_distinct_chars 14
end

def detect_distinct_chars(size)
  idx = 0

  input.reduce([]) do |acc, char|
    if acc.size >= size
      if acc.tally.size == size
        return idx
      else
        acc.shift
        acc << char
      end
    else
      acc << char
    end

    idx += 1
    acc
  end
end

def input
  open('inputs/y2022/day_six.txt').map(&:chomp).first.split('')
end
