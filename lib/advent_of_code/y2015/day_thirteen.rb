def first
  data = input
  check_sitting data
end

def second
  data = input.merge(
    "Santa-Bob" => 0,
    "Santa-Carol" => 0,
    "Santa-David" => 0,
    "Santa-Eric" => 0,
    "Santa-Frank" => 0,
    "Santa-George" => 0,
    "Santa-Alice" => 0,
    "Santa-Mallory" => 0,
    "Bob-Santa" => 0,
    "Carol-Santa" => 0,
    "David-Santa" => 0,
    "Eric-Santa" => 0,
    "Frank-Santa" => 0,
    "George-Santa" => 0,
    "Alice-Santa" => 0,
    "Mallory-Santa" => 0,
  )

  check_sitting data
end

def check_sitting(data)
  invites = data.flat_map { |key,_| key.split('-') }.uniq

  invites.permutation.map do |invs|
    sum = 0

    0.upto(invites.size-1) do |idx|
      prev_idx = idx - 1 >= 0 ? idx - 1 : invites.size - 1
      next_idx = idx + 1 < invites.size ? idx + 1 : 0

      sum += data["#{invs[idx]}-#{invs[next_idx]}"] + data["#{invs[idx]}-#{invs[prev_idx]}"]
    end

    sum
  end.max
end

def input
  open('inputs/y2015/day_thirteen.txt').map(&:chomp).each_with_object({}) do |line, acc|
    line =~ /([\w]+) would ([\w]+) ([\d]+) happiness units by sitting next to ([\w]+)./

    acc["#{$1}-#{$4}"] = $3.to_i * ($2 == 'gain' ? 1 : -1)
  end
end
