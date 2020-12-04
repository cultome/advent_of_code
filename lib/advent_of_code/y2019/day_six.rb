Node = Struct.new(:name, :parent, :children) do
  def to_s
    name
  end
end

def hierarchy(node, curr = [])
  return curr if node.parent.nil?

  curr.unshift node.parent
  hierarchy node.parent, curr
end

def walk_tree(node, sum = 0)
  if node.children.empty?
    sum
  else
    node.children.reduce(sum) do |acc, child|
      acc + walk_tree(child, sum + 1)
    end
  end
end

def build_tree(lines)
  dict = {}

  lines.each do |line|
    parent, child = line.split(")")

    parent_node = (dict[parent] ||= Node.new(parent, nil, []))
    child_node = (dict[child] ||= Node.new(child, nil, []))

    child_node.parent = parent_node
    parent_node.children.push(child_node)
  end

  root = dict.values.find{ |node| node.parent.nil? }
  [root, dict]
end

def first
  root, _ = build_tree input
  total = walk_tree root

  total
end

def second
  _, dict = build_tree input
  you_hierarchy = hierarchy dict["YOU"]
  san_hierarchy = hierarchy dict["SAN"]

  common_parent = you_hierarchy.reduce(nil) { |acc,parent| san_hierarchy.include?(parent) ? parent : acc }

  you_dist = you_hierarchy.drop_while{|h| h != common_parent }.size - 1
  san_dist = san_hierarchy.drop_while{|h| h != common_parent }.size - 1

  you_dist + san_dist
end

def input
  open('inputs/y2019/day_six.txt').map(&:chomp)
end
