def first
  res = results
  scores = input.each_with_object({}) do |(name, props), acc|
    acc[name] = props.count { |k,v| res[k] == props[k] }
  end

  max = scores.values.max
  scores.find { |_, v| v == max }.first
end

def second
  reference = results
  gt = %w[cats trees]
  lt = %w[pomeranians goldfish]
  scores = input.each_with_object({}) do |(name, props), acc|
    acc[name] = props.count do |k,v|
      if gt.include? k
        reference[k] < props[k]
      elsif lt.include? k
        reference[k] > props[k]
      else
        reference[k] == props[k]
      end
    end
  end

  max = scores.values.max
  scores.find { |_, v| v == max }.first
end

def results
  {
    'children' => 3,
    'cats' => 7,
    'samoyeds' => 2,
    'pomeranians' => 3,
    'akitas' => 0,
    'vizslas' => 0,
    'goldfish' => 5,
    'trees' => 3,
    'cars' => 2,
    'perfumes' => 1,
  }
end

def input
  open('inputs/y2015/day_sixteen.txt').map(&:chomp).each_with_object(Hash.new{|h,k| h[k] = {}}) do |line, acc|
    name = line.split(': ').first.split(' ').last.to_i

    line
      .split(/Sue ([\d]+): (.*)/)
      .last
      .split(', ')
      .map { |p| p.split(': ') }
      .each { |k,v| acc[name][k] = v.to_i }
  end
end
