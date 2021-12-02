def first
  elves = (1..3018458).to_a

  loop do
    break if elves.size == 1

    is_odd = elves.size.odd?
    elves.delete_if.with_index { |elf, idx| idx.odd? }

    if is_odd
      elves.unshift elves.pop
    end
  end

  elves.first
end

def second
  elves = (1..3018458).to_a
  idx = 0

  loop do
    print "#{elves.size}     \r"
    #puts "[*] #{elves.inspect}"
    break if elves.size == 1

    idx_to_delete = (elves.size / 2 + idx) % elves.size
    #puts " #{elves[idx]} <- #{idx} | #{idx_to_delete} => #{elves[idx_to_delete]}"
    elves.delete_at idx_to_delete

    idx = (idx + (idx_to_delete > idx ? 1 : 0)) % elves.size
  end

  # 259778 too low
  elves.first
end
