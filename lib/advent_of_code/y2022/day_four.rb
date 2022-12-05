def first
  input.select do |one, two|
    (one - two).empty? || (two - one).empty?
  end.size
end

def second
  input.select do |one, two|
    (one - two).size != one.size || (two - one).size != two.size
  end.size
end

def input
  open('inputs/y2022/day_four.txt')
    .map(&:chomp)
    .map do |line|
      line.split(',').map do |rg|
        s, e = rg.split('-').map(&:to_i)
        (s..e).to_a
      end
    end
end
