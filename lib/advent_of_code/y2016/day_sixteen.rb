def first
  data = generate "11011110011011101", 272
  pairs = data.scan(/../).to_a
  checksum = "--"

  loop do
    return checksum unless checksum.size.even?

    checksum = pairs.map { |ab| ab == '00' || ab == '11' ? '1' : '0' }.join
    pairs = checksum.scan(/../).to_a
  end
end

def second
  data = generate "11011110011011101", 35651584
  pairs = data.scan(/../).to_a
  checksum = "--"

  loop do
    return checksum unless checksum.size.even?

    checksum = pairs.map { |ab| ab == '00' || ab == '11' ? '1' : '0' }.join
    pairs = checksum.scan(/../).to_a
  end
end

def generate(seed, target)
  data = seed

  loop do
    return data[0...target] if data.size >= target

    b = data.reverse.tr('01', '10')
    data = "#{data}0#{b}"
  end
end
