def first
  rx = Hash.new { |h,k| h[k] = 0 }

  input.each do |i|
    if rx[i[:arg1]].send(i[:cond], i[:arg2])
      if i[:op] == :inc
        rx[i[:reg]] += i[:val]
      elsif i[:op] == :dec
        rx[i[:reg]] -= i[:val]
      end
    end
  end

  rx.values.max
end

def second
  rx = Hash.new { |h,k| h[k] = 0 }
  max = -1

  input.each do |i|
    if rx[i[:arg1]].send(i[:cond], i[:arg2])
      if i[:op] == :inc
        rx[i[:reg]] += i[:val]
      elsif i[:op] == :dec
        rx[i[:reg]] -= i[:val]
      end
    end

    max = rx.values.max if max < rx.values.max
  end

  max
end

def input
  open('inputs/y2017/day_fifteen.txt').map(&:chomp).map do |line|
    reg, op, val, _, arg1, cond, arg2 = line.split(' ')

    {
      reg: reg.to_sym,
      op: op.to_sym,
      val: val.to_i,
      arg1: arg1.to_sym,
      cond: cond.to_sym,
      arg2: arg2.to_i,
    }
  end
end
