def first
  race_time = 2_503#secs

  input.map do |reno, speed, runtime, rest|
    calculate_distance race_time, speed, runtime, rest
  end.max
end

def second
  race_time = 2_503#secs
  data = input
  distance_renos = Hash.new { |h,k| h[k] = 0 }
  renos_points = Hash.new { |h,k| h[k] = 0 }

  race_time.times do |race_time|
    input.map do |reno, speed, runtime, rest|
      distance_renos[reno] = calculate_distance race_time+1, speed, runtime, rest
    end

    max_current_distance = distance_renos.values.max
    distance_renos.each do |name, distance|
      renos_points[name] += distance == max_current_distance ? 1 : 0
    end
  end

  renos_points.values.max
end

def calculate_distance(race_time, speed, runtime, rest)
  cycles = race_time / (runtime + rest)
  last_cycle = (race_time % (runtime + rest))
  runtime_rest = last_cycle > runtime ? runtime : last_cycle

  cycles * runtime * speed + runtime_rest * speed
end

def input
  open('inputs/y2015/day_fourteen.txt').map(&:chomp).map do |line|
    line =~ /([\w]+) can fly ([\d]+) km\/s for ([\d]+) seconds, but then must rest for ([\d]+) seconds./
    [$1, $2.to_i, $3.to_i, $4.to_i]
  end
end
