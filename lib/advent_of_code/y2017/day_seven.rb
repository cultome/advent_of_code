def first
  records = input

  values = records.values.flat_map { |hsh| hsh[:children] }
  records.keys.find { |name| !values.include?(name) }
end

def second
  records = input
  root = first

  walk records[root], records
rescue Exception => error
  error.message
end

def walk(node, records)
  return node[:weight] if node[:children].empty?

  branches = node[:children].map do |name|
    walk(records[name], records)
  end

  groups = branches.group_by { |n| n }
  wrong_value = groups.find { |k, v| v.size == 1 }

  unless wrong_value.nil?
    right_value = groups.keys.find { |v| v != wrong_value.first }
    offset = wrong_value.first - right_value

    child_idx = branches.find_index { |v| v == wrong_value.first }
    raise (records[node[:children][child_idx]][:weight] - offset).to_s
  end

  node[:weight] + branches.sum
end

def input
  open('inputs/y2017/day_seven.txt').map(&:chomp).each_with_object({}) do |line, acc|
    parent, children = line.split(' -> ')
    parent =~ /^([\w]+) \(([\d]+)\)$/

    acc[$1] = { weight: $2.to_i, children: [] }

    unless children.nil?
      acc[$1][:children] = children.split(', ')
    end
  end
end
