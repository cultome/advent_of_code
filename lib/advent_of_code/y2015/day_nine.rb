require 'set'

def first
  calculate_route_weights.first.last
end

def second
  calculate_route_weights.last.last
end

def input
  open('inputs/y2015/day_nine.txt').map(&:chomp)
end

def calculate_route_weights
  graph = input.each_with_object(Hash.new { |h, k| h[k] = Node.new }) do |line, acc|
    line =~ /^(.+?) to (.+?) = ([\d]+)$/

    acc[$1].name = $1
    acc[$2].name = $2
    acc[$1].add $2, acc[$2], $3.to_i
    acc[$2].add $1, acc[$1], $3.to_i
  end

  starting_locs = graph.keys
  pending_to_visit = graph.keys

  all_routes = starting_locs.flat_map do |start|
    walk graph[start], [start], graph
  end

  route_weights = Hash.new { |h, k| h[k] = 0 }
  all_routes.each do |route|
    route_id = route.join(' -> ')
    current = nil

    route.each do |loc|
      unless current.nil?
        route_weights[route_id] += current.connection_weight[loc]
      end

      current = graph[loc]
    end
  end

  route_weights.entries.sort_by(&:last)
end

def walk(current, visited, graph)
  nexts = Set.new current.connection.keys
  pasts = Set.new visited
  missing = nexts - pasts

  if missing.empty?
    [visited]
  else
    missing.flat_map do |start|
      walk graph[start], [*visited, start], graph
    end
  end
end

class Node
  attr_accessor :name, :connection, :connection_weight

  def initialize
    @name = "-"
    @connection = {}
    @connection_weight = {}
  end

  def add(name, node, weight)
    @connection[name] = node
    @connection_weight[name] = weight
  end

  def inspect
    "[#{name}] -> [#{connection.map { |k, _| k }.join(',')}]"
  end
end
