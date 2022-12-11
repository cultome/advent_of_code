def first
  run 20 do |worry_lvl|
    lvl = worry_lvl / 3

    [lvl, lvl]
  end
end

def second
  least_common_multiple = input.map { |m| m[:test] }.reduce(&:lcm)

  run 10_000 do |worry_lvl|
    [worry_lvl, worry_lvl % least_common_multiple]
  end
end

def run(rounds)
  monkeys = input

  1.upto(rounds) do |round|
    monkeys.each do |monkey|
      while !monkey[:items].empty?
        worry = monkey[:items].shift
        monkey[:inspected] += 1

        op, val = monkey[:operation]
        value = val == 'old' ? worry : val
        worry_level = worry.send(op, value)

        worry_lvl_cmp, worry_lvl_save = yield worry_level

        branch = worry_lvl_cmp % monkey[:test] == 0
        monkeys[monkey[branch.to_s.to_sym]][:items] << worry_lvl_save
      end
    end
  end

  monkeys.map { |m| m[:inspected] }.sort[-2..].reduce(&:*)
end

def input
  idx = 0
  open('inputs/y2022/day_eleven.txt').map(&:chomp).each_with_object([]) do |line, acc|
    if line.start_with? 'Monkey '
      acc[idx] = { id: idx, items: [], operation: '', test: '', true: '', false: '', inspected: 0 }
    elsif line.start_with? '  Starting items: '
      acc[idx][:items] = line[18..].split(', ').map(&:to_i)
    elsif line.start_with? '  Operation: new = '
      op, value = line[23..].split(' ')
      value =  value == 'old' ? 'old' : value.to_i

      acc[idx][:operation] = [op, value]
    elsif line.start_with? '  Test: '
      acc[idx][:test] = line[21..].to_i
    elsif line.start_with? '    If true: '
      acc[idx][:true] = line[29..].to_i
    elsif line.start_with? '    If false: '
      acc[idx][:false] = line[30..].to_i
    else
      idx += 1
    end
  end
end
