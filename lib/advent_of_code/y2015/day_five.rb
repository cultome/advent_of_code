def first
  input.count do |line|
    next if line.gsub(/[^aeiou]/, '').size < 3
    next if line =~ /(ab|cd|pq|xy)/

    letters = line.split('')
    next if letters.find.with_index { |chr, idx| chr == letters[idx + 1] }.nil?

    true
  end
end

def second
  input.count do |line|
    next if line !~ /([a-z]{2})(?=[a-z]{2}).*\1/
    next if line !~ /([a-z])[a-z](?=[a-z])\1/

    true
  end
end

def input
  open('inputs/y2015/day_five.txt').map(&:chomp)
end
