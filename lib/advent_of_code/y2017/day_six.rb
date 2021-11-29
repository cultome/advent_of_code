def first
  banks = input
  configs = []
  cycles = 0

  loop do
    break if configs.include? banks.join(";")

    configs << banks.join(";")

    idx = banks.find_index{|idx| idx == banks.max }
    share = banks[idx]
    banks[idx] = 0

    while share > 0
      banks.size.times do |bidx|
        next if share <= 0

        banks[(idx + 1 + bidx) % banks.size] += 1
        share -= 1
      end
    end

    cycles += 1
  end

  cycles
end

def second
  banks = input
  configs = []

  loop do
    if configs.include? banks.join(";")
      curre_conf = banks.join(";")

      idx = configs.find_index(curre_conf)
      return configs.size - idx
    end


    configs << banks.join(";")

    idx = banks.find_index{|idx| idx == banks.max }
    share = banks[idx]
    banks[idx] = 0

    while share > 0
      banks.size.times do |bidx|
        next if share <= 0

        banks[(idx + 1 + bidx) % banks.size] += 1
        share -= 1
      end
    end
  end
end

def input
  open('inputs/y2017/day_six.txt').map(&:chomp).first.split(' ').map(&:to_i)
end
