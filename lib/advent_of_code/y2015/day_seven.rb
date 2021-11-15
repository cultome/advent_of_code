def input_value(cmd, id, wires)
  case cmd["input#{id}_type".to_sym]
  when 'value'
    cmd["input#{id}".to_sym].to_i
  when 'reference'
    wires[cmd["input#{id}".to_sym]]
  when nil
    nil
  else
    raise "Unable to use input from [#{cmd}]"
  end
end

def first
  wires = process input
  wires['a']
end

def second
  a_val = first

  lines = input
  lines[3] = parse_cmd("#{a_val} -> b")

  wires = process lines
  wires['a']
end

def process(lines)
  wires = {}

  binary_action = %w[OR AND RSHIFT LSHIFT]

  while !lines.empty?
    cmd = lines.shift
    val1 = input_value(cmd, 1, wires)
    val2 = input_value(cmd, 2, wires)

    if val1.nil?
      lines.push cmd
      next
    end

    if val2.nil? && binary_action.include?(cmd[:action])
      lines.push cmd
      next
    end

    wires[cmd[:result]] = case cmd[:action]
                          when 'NOT'
                            val1.to_s(2).rjust(16, '0').tr('01', '10').to_i(2)
                          when 'ASSIGN'
                            val1
                          when 'OR'
                            val1 | val2
                          when 'AND'
                            val1 & val2
                          when 'RSHIFT'
                            val1 >> val2
                          when 'LSHIFT'
                            val1 << val2
                          else
                            raise "Invalid action for [#{cmd}]"
                          end
  end

  # puts wires.entries.delete_if{|_,n| n.zero? }.sort_by(&:first).map { |k, v| "#{k.rjust(4)} => #{v}"}.join("\n")
  wires
end

def input
  open('inputs/y2015/day_seven.txt').map(&:chomp).map do |line|
    parse_cmd line
  end
end

def parse_cmd(line)
  if line =~ /^NOT ([\w\d]+) -> ([\w]+)$/
    {
      action: 'NOT',
      input1: $1,
      input1_type: $1.match?(/^[\d]+$/) ? 'value' : 'reference',
      input2: nil,
      input2_type: nil,
      result: $2,
    }
  elsif line =~ /^([\w\d]+) -> ([\w]+)$/
    {
      action: 'ASSIGN',
      input1: $1,
      input1_type: $1.match?(/^[\d]+$/) ? 'value' : 'reference',
      input2: nil,
      input2_type: nil,
      result: $2,
    }
  elsif line =~ /^([\w\d]+) ([A-Z]+) ([\w\d]+) -> ([\w]+)$/
    {
      action: $2,
      input1: $1,
      input1_type: $1.match?(/^[\d]+$/) ? 'value' : 'reference',
      input2: $3,
      input2_type: $3.match?(/^[\d]+$/) ? 'value' : 'reference',
      result: $4,
    }
  else
    raise "Unable to parse [#{line}]"
  end
end
