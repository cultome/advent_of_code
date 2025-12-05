require 'pry'

def first
  return 0

  operators = %i[+ *]
  data = input

  valid_equations = data.select do |hsh|
    n = hsh[:values].size - 1
    (operators * n).combination(n).uniq.any? do |ops|
      calibration = hsh[:values].reduce do |acc, num|
        break if acc > hsh[:result]

        op = ops.shift
        acc.send op, num
      end

      calibration == hsh[:result]
    end
  end

  valid_equations.map { |hsh| hsh[:result] }.sum
end

def second
  operators = %i[+ * |]
  data = input

  valid_equations = data.select do |hsh|
    print '.'
    n = hsh[:values].size - 1
    (operators * n).combination(n).uniq.any? do |ops|
      calibration = hsh[:values].reduce do |acc, num|
        break if acc > hsh[:result]

        op = ops.shift
        if op == :|
          "#{acc}#{num}".to_i
        else
          acc.send op, num
        end
      end

      calibration == hsh[:result]
    end
  end

  valid_equations.map { |hsh| hsh[:result] }.sum
end

def input
  open('inputs/y2024/day_7.txt').map(&:chomp).map do |line|
    result, values = line.split ': '
    {
      result: result.to_i,
      values: values.split.map(&:to_i),
    }
  end
end
