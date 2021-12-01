def first
  configs = input
  initial = 0

  loop do
    aligns = []

    configs.each_with_index do |disc, idx|
      aligns << (disc[:initial] + idx + 1 + initial) % disc[:pos]
    end

    return initial if aligns.all?(&:zero?)

    initial += 1
  end
end

def second
  configs = input
  configs << { disc: 7, pos: 11, initial: 0 }
  initial = 0

  loop do
    aligns = []

    configs.each_with_index do |disc, idx|
      aligns << (disc[:initial] + idx + 1 + initial) % disc[:pos]
    end

    return initial if aligns.all?(&:zero?)

    initial += 1
  end
end

def input
  open('inputs/y2016/day_fifteen.txt').map(&:chomp).map do |line|
    line =~ /^Disc #([\d]+) has ([\d]+) positions; at time=0, it is at position ([\d]+).$/

    { disc: $1.to_i, pos: $2.to_i, initial: $3.to_i }
  end
end
