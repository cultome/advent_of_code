require 'json'

def first
  input.flat_map { |line| line.scan(/[-\d]+/) }.map(&:to_i).sum
end

def second
  root = JSON.parse(File.read('inputs/y2015/day_twelve.txt'))

  clean_obj = root.map do |obj|
    check_object obj
  end

  clean_obj.to_json.scan(/[-\d]+/).map(&:to_i).sum
end

def check_object(obj)
  if obj.is_a?(Hash)
    if obj.values.include? 'red'
      {}
    else
      obj.each_with_object({}) do |(key, val), acc|
        acc[key] = check_object(val)
      end
    end
  elsif obj.is_a?(Array)
    obj.each_with_object([]) do |val, acc|
      acc << check_object(val)
    end
  else
    obj
  end
end

def input
  open('inputs/y2015/day_twelve.txt').map(&:chomp)
end
