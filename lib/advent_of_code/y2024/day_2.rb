def first
  input
    .map { |report| check report }
    .select(&:itself)
    .size
end

def second
  valids = input.map do |report|
    if check report
      true
    else
      report.combination(report.size - 1).any? do |alt|
        check alt
      end
    end
  end.select(&:itself)

  valids.size
end

def input
  open('inputs/y2024/day_2.txt').map(&:chomp).map do |line|
    line.split(/\s+/).map(&:to_i)
  end
end

def check(report)
  diff = []

  report.reduce do |acc, level|
    diff << (acc - level)

    level
  end

  if diff.all?(&:positive?)
    diff.all? { |d| (1..3).include? d }
  elsif diff.all?(&:negative?)
    diff.all? { |d| (1..3).include? d.abs }
  else
    false
  end
end
