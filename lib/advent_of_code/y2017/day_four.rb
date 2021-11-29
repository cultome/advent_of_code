def first
  input.select do |words|
    words.size == words.uniq.size
  end.size
end

def second
  input.select do |words|
    sorted = words.map{|w| w.split('').sort.join }

    words.size == words.uniq.size && sorted.size == sorted.uniq.size
  end.size
end

def input
  open('inputs/y2017/day_four.txt').map(&:chomp).map do |line|
    line.split(' ')
  end
end
