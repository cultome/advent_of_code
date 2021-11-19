def first
  run_program
end

def second
  run_program 1
end

def run_program(c_init = 0)
  program = input
  ptr = 0
  registers = {
    'a' => 0,
    'b' => 0,
    'c' => c_init,
    'd' => 0,
  }

  while (cmd = program[ptr])
    case cmd[:cmd]
    when 'cpy'
      val = cmd[:arg1_type] == :value ? cmd[:arg1] : registers[cmd[:arg1]]
      registers[cmd[:arg2]] = val
      ptr += 1
    when 'inc'
      registers[cmd[:arg1]] += 1
      ptr += 1
    when 'dec'
      registers[cmd[:arg1]] -= 1
      ptr += 1
    when 'jnz'
      val = cmd[:arg1_type] == :value ? cmd[:arg1] : registers[cmd[:arg1]]
      if val > 0
        ptr += cmd[:arg2]
      else
        ptr += 1
      end
    else
      raise "Invalid command"
    end
  end

  registers['a']
end

def input
  open('inputs/y2016/day_twelve.txt').map(&:chomp).map do |line|
    words = line.split(' ')
    cmd = words.first
    arg1, arg2 = words[1..]
    arg1_type = arg1 =~ /^[a-z]+$/ ? :register : :value
    arg2_type = arg2 =~ /^[a-z]+$/ ? :register : :value

    {
      cmd: cmd,
      arg1: (arg1_type == :value ? arg1.to_i : arg1),
      arg1_type: arg1_type,
      arg2: (arg2_type == :value ? arg2.to_i : arg2),
      arg2_type: arg2_type,
    }
  end
end
