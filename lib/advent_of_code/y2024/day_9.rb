require 'pry'

def first
  blocks = input

  loop do
    big_idx = blocks.rindex { |num| num >= 0 }
    empty_idx = blocks.index { |num| num == -1 }

    break if big_idx.nil? || empty_idx.nil? || empty_idx > big_idx

    blocks[empty_idx] = blocks[big_idx]
    blocks[big_idx] = -2
  end

  blocks.map.with_index { |num, idx| num * idx if num >= 0 }.compact.sum
end

def second
  blocks = input2

  loop do
    empty_idx = blocks.index { |b| b[:file] == -1 }

    break if empty_idx.nil?

    big_idx = blocks.rindex { |b| b[:file] >= 0 }

    break if big_idx.nil? || empty_idx > big_idx

    moved_block = blocks[big_idx]
    binding.pry
    blocks[empty_idx][:size] -= blocks[big_idx][:size]
    blocks.insert empty_idx, moved_block.clone
    moved_block[:file] = -1

    # compact
    current_idx = -1
    empty_idx = 0
    loop do
      current_idx += empty_idx + 1
      empty_idx = blocks[current_idx..].index { |b| b[:file] == -1 }

      # is next block is empty
      break if empty_idx.nil?

      next unless blocks.dig(current_idx + empty_idx + 1, :file) == -1

      blocks[current_idx + empty_idx][:size] += blocks[current_idx + empty_idx + 1][:size]
      blocks.delete_at current_idx + empty_idx + 1
    end
  end

  binding.pry
  blocks.flat_map { |b| [b[:file]] * b[:size] }
end

def input
  open('inputs/y2024/day_9.txt').map(&:chomp).first.scan(/(.)(.?)/).flat_map.with_index do |(fsize, esize), idx|
    ([idx] * fsize.to_i) + ([-1] * esize.to_i)
  end
end

def input2
  blocks = []

  open('inputs/y2024/day_9.txt').map(&:chomp).first.scan(/(.)(.?)/).flat_map.with_index do |(fsize, esize), idx|
    blocks << {
      file: idx,
      size: fsize.to_i,
    }

    blocks << {
      file: -1,
      size: esize.to_i,
    }
  end

  blocks
end
