PRIORITIES = ('a'..'z').to_a + ('A'..'Z').to_a

def first
  input.map do |items|
    middle = items.size / 2
    one = items[0...middle]
    two = items[middle..]

    PRIORITIES.index((one & two).first) + 1
  end.sum
end

def second
  groups = input
    .group_by
    .with_index { |v, idx| idx / 3}
    .map(&:last)
    .map { |grp| grp.reduce { |acc, grp| acc & grp } }
    .map { |char| PRIORITIES.index(char.first) + 1 }
    .sum
end

def input
  open('inputs/y2022/day_three.txt').map(&:chomp).map { |line| line.split('') }
end
