def first
  grid = input

  h = grid.map(&:join)
  # horizontal
  xh = h.flat_map { |row| row.scan('XMAS').to_a }
  # horizontal reverse
  xhr = h.flat_map { |row| row.scan('SAMX').to_a }

  r = grid.transpose.map(&:join)
  # vertical
  xv = r.flat_map { |row| row.scan('XMAS').to_a }
  # vertical reverse
  xvr = r.flat_map { |row| row.scan('SAMX').to_a }

  xdr = []
  xdrr = []
  grid.each_with_index do |row, y|
    row.each_with_index do |_, x|
      # diagonal right
      continue = true
      %w[X M A S].each_with_index do |ref, offset|
        next unless continue

        continue = false if grid.dig(y + offset, x + offset).nil? || grid.dig(y + offset, x + offset) != ref
      end

      xdr << 'XMAS' if continue

      # diagonal right reverse
      continue = true
      %w[S A M X].each_with_index do |ref, offset|
        next unless continue

        continue = false if grid.dig(y + offset, x + offset).nil? || grid.dig(y + offset, x + offset) != ref
      end

      xdrr << 'SAMX' if continue
    end
  end

  xdl = []
  xdlr = []
  grid.each_with_index do |row, y|
    row.each_with_index do |_, x|
      # diagonal left
      continue = true
      %w[X M A S].each_with_index do |ref, offset|
        next unless continue

        if y + offset < 0 || x - offset < 0 || grid.dig(y + offset, x - offset).nil? || grid.dig(y + offset, x - offset) != ref
          continue = false
        end
      end

      xdl << 'SAMX' if continue

      # diagonal left reverse
      continue = true
      %w[S A M X].each_with_index do |ref, offset|
        next unless continue

        next unless (y + offset).negative? ||
                    (x - offset).negative? ||
                    grid.dig(y + offset, x - offset).nil? ||
                    grid.dig(y + offset, x - offset) != ref

        continue = false
      end

      xdlr << 'SAMX' if continue
    end
  end

  [xh, xhr, xv, xvr, xdr, xdrr, xdl, xdlr].map(&:size).sum
end

def second
  grid = input

  xdr = []
  grid.each_with_index do |row, y|
    row.each_with_index do |_, x|
      # diagonal right
      continue = true
      %w[M A S].each_with_index do |ref, offset|
        next unless continue

        continue = false if grid.dig(y + offset, x + offset).nil? || grid.dig(y + offset, x + offset) != ref
      end

      xdr << "#{y + 1}, #{x + 1}" if continue

      # diagonal right reverse
      continue = true
      %w[S A M].each_with_index do |ref, offset|
        next unless continue

        continue = false if grid.dig(y + offset, x + offset).nil? || grid.dig(y + offset, x + offset) != ref
      end

      xdr << "#{y + 1}, #{x + 1}" if continue
    end
  end

  xdl = []
  grid.each_with_index do |row, y|
    row.each_with_index do |_, x|
      # diagonal left
      continue = true
      %w[M A S].each_with_index do |ref, offset|
        next unless continue

        if y + offset < 0 || x - offset < 0 || grid.dig(y + offset, x - offset).nil? || grid.dig(y + offset, x - offset) != ref
          continue = false
        end
      end

      xdl << "#{y + 1}, #{x - 1}" if continue

      # diagonal left reverse
      continue = true
      %w[S A M].each_with_index do |ref, offset|
        next unless continue

        next unless (y + offset).negative? ||
                    (x - offset).negative? ||
                    grid.dig(y + offset, x - offset).nil? ||
                    grid.dig(y + offset, x - offset) != ref

        continue = false
      end

      xdl << "#{y + 1}, #{x - 1}" if continue
    end
  end

  (xdr & xdl).size
end

def input
  open('inputs/y2024/day_4.txt').map(&:chomp).map(&:chars)
end
