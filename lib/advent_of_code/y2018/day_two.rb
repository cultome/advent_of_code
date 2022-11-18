require 'text'

def first
  sizes = input.
    map { |line| line.split('').group_by { |chr| chr } }.
    map(&:values).
    map { |grp| grp.map(&:size) }

  group_of_two = sizes.select { |grp| grp.include? 2 }.size
  group_of_three = sizes.select { |grp| grp.include? 3 }.size

  group_of_two * group_of_three
end

def second
  words = input

  word = words.pop
  while !words.empty?
    found = words.find { |w| Text::Levenshtein.distance(w, word) == 1 }

    return [word, found] if !found.nil?

    word = words.pop
  end
end

def input
  open('inputs/y2018/day_two.txt').map(&:chomp)
end
