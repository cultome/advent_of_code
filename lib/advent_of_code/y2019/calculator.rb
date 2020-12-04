module Calculator
  def execute_intcode(program, **opcs)
    state = {last_output: nil, pointer: 0, version: 1, read_from: :read_console, terminated: false}.merge(opcs)

    loop do
      value, cmd, cmd_arg = read_command program, state[:pointer], state[:version], state[:read_from]

      case cmd
      when :move
        state[:pointer] += cmd_arg

      when :return
        state[:pointer] += cmd_arg

        if state[:version] == 3
          state[:last_output] = value
          return state
        end
      when :set
        state[:pointer] = cmd_arg

      when :terminate
        state[:last_output] = program[0] if state[:version] == 1
        state[:terminated] = true

        return state
      end

      state[:last_output] = value
    end
  end

  def read_command(program, pointer, version, read_from)
    if version == 1
      opcode = program[pointer].to_i

      p1 = resolve_value(1, 0, pointer, program)
      p2 = resolve_value(2, 0, pointer, program)
      p3 = resolve_value(3, 1, pointer, program)
    elsif [2,3,4].include? version
      op = program[pointer].to_s.rjust(5, "0")

      p3m = op[0].to_i
      p2m = op[1].to_i
      p1m = op[2].to_i
      opcode = op[3..4].to_i

      p1 = resolve_value(1, p1m, pointer, program)
      p2 = resolve_value(2, p2m, pointer, program)
      p3 = resolve_value(3, p3m == 0 ? 1 : p3m, pointer, program)
    end

    case opcode
    when 1 # sum
      #logger.debug "[#{pointer}] #{p1} + #{p2} => #{p3}"
      program[p3] = p1 + p2

      [program[p3], :move, 4]
    when 2 # multiply
      #logger.debug "[#{pointer}] #{p1} * #{p2} => #{p3}"
      program[p3] = p1 * p2

      [program[p3], :move, 4]
    when 3 # input
      prompt "input> "
      input_value = send read_from

      p3 = program[pointer + 1] if version < 4

      #logger.debug "\n[#{pointer}] input #{input_value} => #{p3}"
      program[p3] = input_value

      [p3, :move, 2]
    when 4 # output
      #logger.debug "[#{pointer}] output #{p1}"
      #logger.info "output> #{p1}"

      [p1, :return, 2]
    when 5 # jump-if-true
      if p1 != 0
        #logger.debug "[#{pointer}] jump if true goto #{p2}"
        [-1, :set, p2]
      else
        #logger.debug "[#{pointer}] jump if true noop"
        [-1, :move, 3]
      end
    when 6 # jump-if-false
      if p1 == 0
        #logger.debug "[#{pointer}] jump if false goto #{p2}"
        [-1, :set, p2]
      else
        #logger.debug "[#{pointer}] jump if false noop"
        [-1, :move, 3]
      end
    when 7 # less than
      program[p3] = p1 < p2 ? 1 : 0
      #logger.debug "[#{pointer}] less than set #{program[p3]} => #{p3}"

      [-1, :move, 4]
    when 8 # equals
      program[p3] = p1 == p2 ? 1 : 0
      #logger.debug "[#{pointer}] equals set #{program[p3]} => #{p3}"

      [-1, :move, 4]

    when 9 # adjusts the relative base
      @relative_base += p1

      [-1, :move, 2]

    when 99 # exit
      #logger.debug "[#{pointer}] terminate"
      [nil, :terminate, nil]
    else
      raise "Invalid opcode [#{opcode} -> #{op}]"
    end
  rescue Exception => err
    raise err
  end

  def resolve_value(pid, mode, pointer, program)
    return -1 if program.size <= pointer + pid

    raw_value = program[pointer + pid]
    if mode == 0
      program[raw_value] || 0
    elsif mode == 1
      raw_value
    elsif mode == 2
      if pid == 3
        @relative_base + raw_value
      else
        program[@relative_base + raw_value]
      end
    else
      raise "Invalid parameter mode [#{mode}]"
    end
  end

  def read_console
    STDIN.gets.chomp.to_i
  end

  def read_buffer
    @input_buffer.shift
  end
end
