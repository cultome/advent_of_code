def first
  find_next input.first
end

def second
  find_next find_next(input.first)
end

def find_next(value)
  expr = 'aa|bb|cc|dd|ee|ff|gg|hh|jj|kk|mm|nn|pp|kk|rr|ss|tt|uu|vv|ww|xx|yy|zz'

  count = 0
  while true do
    value = value.succ

    count += 1
    puts("[*] #{value} -> #{count}...") if count % 10_000_000 == 0

    # rule 2
    next if value.include?('i') || value.include?('l') || value.include?('o')

    # rule 1
    next unless value =~ /(abc|bcd|cde|def|efg|fgh|ghj|hjk|jkm|kmn|mnp|npq|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz)/
    match0 = $1

    # rule 3
    next unless value =~ /(#{expr})/
    match1 = $1

    second_expr = expr.gsub("#{match1}", '').gsub('||', '|').gsub(/^\|/, '').gsub(/\|$/, '')
    next unless value =~ /(#{second_expr})/
    match2 = $1

    # non-overlapping rule
    # aaa is a overlapped match
    next if value =~ /(#{match1[0]}#{match1[0]}#{match1[0]}|#{match2[0]}#{match2[0]}#{match2[0]})/
    next if match1[0].succ == match2[0]

    break
  end

  value
end

def input
  open('inputs/y2015/day_eleven.txt').map(&:chomp)
end
