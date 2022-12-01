def first
  group_by_elf
    .sort_by { |k,v| v }
    .reverse
    .first
    .last
end

def second
  group_by_elf
    .sort_by { |k,v| v }
    .reverse[0...3]
    .map(&:last)
    .sum
end

def group_by_elf
  elf_idx = 1

  input.each_with_object(Hash.new { |h,k| h[k] = 0 }) do |cals, acc|
    if cals.empty?
      elf_idx += 1
    else
      acc[elf_idx] += cals.to_i
    end
  end
end

def input
  open('inputs/y2022/day_one.txt').map(&:chomp)
end
