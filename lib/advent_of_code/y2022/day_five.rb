def first
  stacks, moves = input

  moves.each do |count, from, to|
    stacks[to].unshift(*stacks[from].shift(count).reverse)
  end

  stacks.map(&:first).join
end

def second
  stacks, moves = input

  moves.each do |count, from, to|
    stacks[to].unshift(*stacks[from].shift(count))
  end

  stacks.map(&:first).join
end

def input
  capturing_crates = true
  moves = []
  stacks = []
  crates = []

  open('inputs/y2022/day_five.txt').map(&:chomp).each do |line|
    if line.empty?
      capturing_crates = false
      next
    end

    if capturing_crates
      # parse stacks
      crate = line.gsub(/[ ]{4}/, ' _').gsub(/\[(\w)\]/, '\1').gsub(' ', '')

      if crate.start_with? '1'
        stacks_count = crate.split('').last.to_i

        crates = crates.map { |crate| crate.ljust(stacks_count, '_') }

        stacks = crates.each_with_object([]) do |crt, acc|
          crt.split('').each_with_index do |id, idx|
            acc[idx] ||= []
            acc[idx] << id if id != '_'
          end
        end
      else
        crates << crate
      end
    else
      # add moves
      line =~ /^move ([\d]+) from ([\d]+) to ([\d]+)$/
      moves << [$1.to_i, $2.to_i - 1, $3.to_i - 1]
    end
  end

  [stacks, moves]
end
