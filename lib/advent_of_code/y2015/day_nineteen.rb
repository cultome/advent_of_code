def first
  data = input
  test = data.pop
  data.pop
  replace = prepare_replacements data
  comb = []

  replace.each do |key, rps|
    idx = 0
    while (idx = test.index(key, idx))
      rps.each do |r|
        t1 = test.clone
        t1[idx, key.size] = r
        comb << t1
      end

      idx += 1
    end
  end

  comb.uniq.size
end

def second
  data = input
  result = data.pop
  data.pop
  replace = prepare_replacements data, true
  steps = 0

  while result.size > 1
    replace.each do |key, val|
      while (idx = result.index(key))
        result[idx, key.size] = val
        steps += 1
      end
    end
  end

  steps
end

def prepare_replacements(data, reverse = false)
  data.each_with_object(Hash.new { |h,k| h[k] = [] }) do |prop, acc|
    name, value = prop.split(' => ')

    if reverse
      acc[value] = name
    else
      acc[name] << value
    end
  end
end

def input
  open('inputs/y2015/day_nineteen.txt').map(&:chomp)
end
