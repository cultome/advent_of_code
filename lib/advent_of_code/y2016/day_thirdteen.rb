require 'set'

class Node
  INPUT = 1350 # 10
  @@nodes = {}

  attr_accessor :x, :y, :parent, :viable, :up, :right, :down, :left

  def initialize(x, y, parent)
    @x = x
    @y = y
    @parent = parent
    @viable = x >= 0 && y >= 0 && !wall?

    @up = nil
    @right = nil
    @down = nil
    @left = nil
  end

  def next_move
    init_children!

    return right if right.viable && right != parent
    return down if down.viable && down != parent
    return left if left.viable && left != parent
    return up if up.viable && up != parent

    @viable = false

    return nil if parent.nil?

    parent.next_move
  end

  def init_children!
    @up = @@nodes["#{x},#{y-1}"] ||= Node.new(x, y-1, self) if @up.nil?
    @right = @@nodes["#{x+1},#{y}"] ||= Node.new(x+1, y, self) if @right.nil?
    @down = @@nodes["#{x},#{y+1}"] ||= Node.new(x, y+1, self) if @down.nil?
    @left = @@nodes["#{x-1},#{y}"] ||= Node.new(x-1, y, self) if @left.nil?
  end

  def wall?
    !((x*x + 3*x + 2*x*y + y + y*y) + INPUT).to_s(2).split('').count { |digit| digit == '1' }.even?
  end

  def to_s
    inspect
  end

  def ==(other)
    return false if x.nil? || y.nil? || other.nil?

    x == other.x && y == other.y
  end

  def inspect
    "(#{x}, #{y}, #{viable})"
  end

  def route
    if parent.nil?
      nil
      #"START"
    else
      [*parent.route, self]
      #"#{parent.route} -> #{inspect}"
    end
  end
end

def first
  root = Node.new 1, 1, nil
  route = walk_maze root
  route.size
end

def second
  root = Node.new 1, 1, nil
  route = walk_maze_2 root, 50
  require 'pry'; binding.pry
  route.size
  # 74 wrong
  # 75 wrong
  # 79 wrong
  # 82 wrong
  # 85 wrong
  # 86 wrong
end

def walk_maze_2(root, limit)
  visited = Set.new([root])

  loop do
    current = root
    route = []

    loop do
      current = current.next_move
      break if current.nil?

      route << current
      visited.add current

      if route.size >= limit
        current.viable = false
        break
      end
    end

    break if current.nil?
  end

  visited
end

def walk_maze(root)
  objx, objy = 31, 39
  current = root
  route = []

  loop do
    current = current.next_move
    break if current.nil?

    break if current.x == objx && current.y == objy

    if route.include? current
      current.viable = false
      next
    end

    route.push current
  end

  current.route
end
