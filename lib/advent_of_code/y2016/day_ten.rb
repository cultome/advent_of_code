def first
  state = {
    bot: Hash.new { |h, k| h[k] = [] },
    output: Hash.new { |h, k| h[k] = [] },
  }

  commands = input

  while !commands.empty?
    cmd = commands.shift

    if cmd[:input_type] == :input_bin
      state[cmd[:output_type]][cmd[:output_id]] << cmd[:input_value]
    elsif cmd[:input_type] == :bot
      if state[cmd[:input_type]][cmd[:input_id]].size < 2
        commands.push cmd
        next
      end

      bot_chips = state[cmd[:input_type]][cmd[:input_id]].pop(2).sort

      return cmd[:input_id] if bot_chips == [17, 61]

      state[cmd[:output_low_type]][cmd[:output_low_id]] << bot_chips.min
      state[cmd[:output_high_type]][cmd[:output_high_id]] << bot_chips.max
    else
      raise "Invalid input type"
    end
  end
end

def second
  state = {
    bot: Hash.new { |h, k| h[k] = [] },
    output: Hash.new { |h, k| h[k] = [] },
  }

  commands = input

  while !commands.empty?
    cmd = commands.shift

    if cmd[:input_type] == :input_bin
      state[cmd[:output_type]][cmd[:output_id]] << cmd[:input_value]
    elsif cmd[:input_type] == :bot
      if state[cmd[:input_type]][cmd[:input_id]].size < 2
        commands.push cmd
        next
      end

      bot_chips = state[cmd[:input_type]][cmd[:input_id]].pop(2).sort

      state[cmd[:output_low_type]][cmd[:output_low_id]] << bot_chips.min
      state[cmd[:output_high_type]][cmd[:output_high_id]] << bot_chips.max
    else
      raise "Invalid input type"
    end
  end

  state[:output].values_at(0, 1, 2).flatten.reduce(&:*)
end

def input
  open('inputs/y2016/day_ten.txt').map(&:chomp).map do |line|
    if line =~ /value ([\d]+) goes to bot ([\d]+)/
      {
        input_type: :input_bin,
        input_value: $1.to_i,

        output_type: :bot,
        output_id: $2.to_i,
      }

    elsif line =~ /bot ([\d]+) gives low to ([\w]+) ([\d]+) and high to ([\w]+) ([\d]+)/
      {
        input_type: :bot,
        input_id: $1.to_i,

        output_low_type: $2.to_sym,
        output_low_id: $3.to_i,

        output_high_type: $4.to_sym,
        output_high_id: $5.to_i,
      }
    else
      raise "Unable to parse instruction"
    end
  end
end
