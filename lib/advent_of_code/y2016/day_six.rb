def first
  input.each_with_object(Hash.new { |h, k| h[k] = [] }) do |vals, acc|
    vals.each_with_index do |letter, idx|
      acc[idx] << letter
    end
  end.transform_values do |col|
    grp = col.group_by { |letter| letter }.transform_values(&:size)
    max = grp.values.max
    grp.find { |_, v| v == max }.first
  end.values.join
end

def second
  input.each_with_object(Hash.new { |h, k| h[k] = [] }) do |vals, acc|
    vals.each_with_index do |letter, idx|
      acc[idx] << letter
    end
  end.transform_values do |col|
    grp = col.group_by { |letter| letter }.transform_values(&:size)
    max = grp.values.min
    grp.find { |_, v| v == max }.first
  end.values.join
end

def input
  open('inputs/y2016/day_six.txt').map(&:chomp).map { |line| line.split('') }
end
