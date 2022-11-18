def first
  input.count do |cmd|
    abba_regular = cmd[:regular].each_with_object([]) do |group, acc|
      (group.size - 3).times { |idx| acc << group[idx..idx + 3] }
    end.any? { |group| group =~ /(.)(.)\2\1/ && $1 != $2 }

    abba_hyper = cmd[:hyper].each_with_object([]) do |group, acc|
      (group.size - 3).times { |idx| acc << group[idx..idx + 3] }
    end.any? { |group| group =~ /(.)(.)\2\1/ && $1 != $2 }

    abba_regular && !abba_hyper
  end
end

def second
  input.count do |cmd|
    aba_groups = cmd[:regular].each_with_object([]) do |group, acc|
      (group.size - 2).times { |idx| acc << group[idx..idx + 2] }
    end.select { |group| group =~ /(.)(.)\1/ && $1 != $2 }

    bab_groups = cmd[:hyper].each_with_object([]) do |group, acc|
      (group.size - 2).times { |idx| acc << group[idx..idx + 2] }
    end.select { |group| group =~ /(.)(.)\1/ && $1 != $2 }

    if !aba_groups.empty? && !bab_groups.empty?
      aba_groups.any? do |group|
        group =~ /(.)(.)./
        bab_key = "#{$2}#{$1}#{$2}"

        bab_groups.include? bab_key
      end
    end
  end
end

def input
  open('inputs/y2016/day_seven.txt').map(&:chomp).map do |line|
    line =~ /^(.+?)\[(.+?)\](.+?)$/

    groups = line.scan(/(.+?)\[(.+?)\]|(.+?)$/).flatten.compact
    regular = groups.select.with_index { |grp, idx| idx % 2 == 0 }
    hypers = groups[1..].select.with_index { |grp, idx| idx % 2 == 0 }

    { regular: regular, hyper: hypers }
  end
end
