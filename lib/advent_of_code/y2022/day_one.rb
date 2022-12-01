def first
  group_by_elf.max
end

def second
  group_by_elf.sort.reverse[0...3].sum
end

def group_by_elf
  elf_idx = 0

  input.each_with_object([]) do |cals, acc|
    if cals.empty?
      elf_idx += 1
    else
      acc[elf_idx] ||= 0
      acc[elf_idx] += cals.to_i
    end
  end
end

def input
  open('inputs/y2022/day_one.txt').map(&:chomp)
end
