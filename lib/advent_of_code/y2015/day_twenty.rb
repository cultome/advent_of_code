require 'prime'

def first
  goal = 36_000_000

  houses = 2
  while true
    gifts = divisors(houses).sum * 10

    break if gifts >= goal

    houses += 1
  end

  houses
end

def second
  goal = 36_000_000

  houses = 2
  while true
    gifts = divisors(houses).select { |n| n * 50 >= houses }.sum * 11

    break if gifts >= goal

    houses += 1
  end

  houses
end

def divisors(num)
  arr = Prime.
    prime_division(num)
    .map { |v,exp| (0..exp).map { |i| v**i } }

  arr.first
    .product(*arr[1..-1])
    .map { |a| a.reduce(:*) }
    .map { |m| [m, num/m] }
    .flatten
    .uniq
    .sort
end
