def first
  input.sum do |line|
    chars_count = line.split('').size
    memory_count = line.
      gsub(/^"/, '').
      gsub(/"$/, '').
      gsub('\\\\', '-').
      gsub('\\"', '-').
      gsub(/\\x[a-f0-9]{2}/, '-').
      size

    chars_count - memory_count
  end
end

def second
  input.sum do |line|
    chars_count = line.split('').size
    encoded_size = line.inspect.size

    encoded_size - chars_count
  end
end

def input
  open('inputs/y2015/day_eight.txt').map(&:chomp)
end
