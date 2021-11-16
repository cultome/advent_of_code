def first
  ingredients = input.values
  props = generate_proportions(ingredients.size)

  props.flat_map do |arr_prop|
    ing_prop = ingredients.zip(arr_prop)

    prop1 = ing_prop.map { |ing, prop| ing['capacity'] * prop }.sum
    prop2 = ing_prop.map { |ing, prop| ing['durability'] * prop }.sum
    prop3 = ing_prop.map { |ing, prop| ing['flavor'] * prop }.sum
    prop4 = ing_prop.map { |ing, prop| ing['texture'] * prop }.sum

    [prop1, prop2, prop3, prop4].map { |n| n >= 0 ? n : 0 }.inject(&:*)
  end.max
end

def second
  ingredients = input.values
  props = generate_proportions(ingredients.size)

  props.flat_map do |arr_prop|
    ing_prop = ingredients.zip(arr_prop)

    prop1 = ing_prop.map { |ing, prop| ing['capacity'] * prop }.sum
    prop2 = ing_prop.map { |ing, prop| ing['durability'] * prop }.sum
    prop3 = ing_prop.map { |ing, prop| ing['flavor'] * prop }.sum
    prop4 = ing_prop.map { |ing, prop| ing['texture'] * prop }.sum

    if ing_prop.map { |ing, prop| ing['calories'] * prop }.sum == 500
      [prop1, prop2, prop3, prop4].map { |n| n >= 0 ? n : 0 }.inject(&:*)
    else
      0
    end
  end.max
end

def generate_proportions(perm_size)
  (0..100)
    .to_a
    .permutation(perm_size)
    .select{ |arr| arr.sum == 100 }
end

def input
  open('inputs/y2015/day_fifthteen.txt').map(&:chomp).each_with_object(Hash.new{|h,k| h[k] = {}}) do |line, acc|
    name = line.split(':').first
    line
      .split(': ')
      .last
      .split(', ')
      .map { |ing| ing.split(' ') }
      .map { |ing, prop| acc[name][ing] = prop.to_i }
  end
end
