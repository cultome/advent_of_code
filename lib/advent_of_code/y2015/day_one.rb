def first
  r = input.group_by { |chr| chr }.transform_values { |v| v.size }
  r['('] - r[')']
end

def second
  floor = 0

  input.each_with_index do |chr, idx|
    floor += (chr == '(' ? 1 : -1)

    return idx + 1 if floor == -1
  end
end

def input
  File.read('inputs/y2015/day_one.txt').chomp.split('')
end
