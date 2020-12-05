def first
  input.size.times.reduce(0) do |acc, idx|
    @input += @input if input[idx + 1].nil?

    acc += input[idx] if input[idx] == input[idx + 1]

    acc
  end
end

def second
  step = input.size / 2

  input.size.times.reduce(0) do |acc, idx|
    @input += @input if input[idx + step].nil?

    acc += input[idx] if input[idx] == input[idx + step]

    acc
  end
end

def input
  @input ||= File.read('inputs/y2017/day_one.txt').chomp.split('').map(&:to_i)
end
