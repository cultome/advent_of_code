def first
  clean_rooms.map { |cmd| cmd[:sector] }.sum
end

def second
  clean_rooms.map do |cmd|
    decrypted = cmd[:content].split('').map do |lt|
      cmd[:sector].times { lt = lt.succ }
      lt[-1]
    end.join

    return cmd[:sector] if decrypted == 'northpoleobjectstorage'
  end
end

def clean_rooms
  input.select do |cmd|
    grouped = cmd[:content]
      .split('')
      .group_by { |char| char }
      .transform_values(&:size)

    check = grouped.values.uniq.sort.reverse.first(5).each_with_object([]) do |ref, acc|
      acc.concat(grouped.select { |_, v| v == ref }.flat_map(&:first).sort)
    end.first(5).join

    cmd[:checksum] == check
  end
end

def input
  open('inputs/y2016/day_four.txt').map(&:chomp).map do |line|
    *content, last = line.split('-')
    last =~ /^([\d]+)\[([\w]+)\]$/

    { content: content.join, sector: $1.to_i, checksum: $2 }
  end
end
