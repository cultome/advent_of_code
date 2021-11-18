def first
  run_program
end

def second
  run_program 1
end

def run_program(a = 0)
  ptr = 0
  program = input.to_a
  @a = a
  @b = 0

  loop do
    inst = program[ptr]

    break if inst.nil?

    case inst[:cmd]
    when :hlf
      #hlf r sets register r to half its current value, then continues with the next instruction.
      new_val = instance_variable_get("@#{inst[:op1]}") / 2
      instance_variable_set("@#{inst[:op1]}", new_val)
      ptr += 1
    when :tpl
      #tpl r sets register r to triple its current value, then continues with the next instruction.
      new_val = instance_variable_get("@#{inst[:op1]}") * 3
      instance_variable_set("@#{inst[:op1]}", new_val)
      ptr += 1
    when :inc
      #inc r increments register r, adding 1 to it, then continues with the next instruction.
      new_val = instance_variable_get("@#{inst[:op1]}") + 1
      instance_variable_set("@#{inst[:op1]}", new_val)
      ptr += 1
    when :jmp
      #jmp offset is a jump; it continues with the instruction offset away relative to itself.
      ptr += inst[:op1].to_i
    when :jie
      #jie r, offset is like jmp, but only jumps if register r is even ("jump if even").
      val = instance_variable_get("@#{inst[:op1]}")

      if val.even?
        ptr += inst[:op2]
      else
        ptr += 1
      end
    when :jio
      #jio r, offset is like jmp, but only jumps if register r is 1 ("jump if one", not odd).
      val = instance_variable_get("@#{inst[:op1]}")

      if val == 1
        ptr += inst[:op2]
      else
        ptr += 1
      end
    end
  end

  @b
end

def input
  open('inputs/y2015/day_twentythree.txt').map(&:chomp).map do |line|
    cmd = line.split(' ').first
    op1, op2 = line.gsub("#{cmd} ", '').split(', ')

    { cmd: cmd.to_sym, op1: op1, op2: op2.to_i }
  end
end
