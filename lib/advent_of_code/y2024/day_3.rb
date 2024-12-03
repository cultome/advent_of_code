def first
  input.scan(/mul\(([\d]{1,3}),([\d]{1,3})\)/).map do |a, b|
    a.to_i * b.to_i
  end.sum
end

def second
  enabled = true
  input.scan(/mul\(([\d]{1,3}),([\d]{1,3})\)|(do)\(\)|(don't)\(\)/).each_with_object([]) do |(a, b, d, n), acc|
    if !d.nil?
      enabled = true
    elsif !n.nil?
      enabled = false
    elsif enabled
      acc << (a.to_i * b.to_i)
    end
  end.sum
end

def input
  open('inputs/y2024/day_3.txt').map(&:chomp).join
end
