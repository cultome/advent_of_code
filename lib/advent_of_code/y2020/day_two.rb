def first
  input.count do |low, high, chr, passwd|
    (low..high).include? passwd.count(chr)
  end
end

def second
  input.count do |low, high, chr, passwd|
    (passwd[low - 1] == chr) ^ (passwd[high - 1] == chr)
  end
end

def input
  open('inputs/y2020/day_two.txt')
    .map(&:chomp)
    .map { |l| l.split(': ') }
    .map do |policy, passwd|
      rg, chr = policy.split(' ')
      low, high = rg.split('-').map(&:to_i)

      [low, high, chr, passwd]
    end
end
