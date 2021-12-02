def first
  group_values = []
  open_groups = []
  state = :reading

  input.each do |chr|
    if state == :ignoring
      state = :garbage
      next
    end

    case chr
    when '{'
      if state == :reading
        open_groups.push chr
      end
    when '}'
      if state == :reading
        group_values << open_groups.size
        open_groups.pop
      end
    when '<'
      if state == :reading
        state = :garbage
      end
    when '>'
      if state == :garbage
        state = :reading
      end
    when '!'
      if state == :garbage
        state = :ignoring
      end
    else
      # TODO?
    end
  end

  group_values.sum
end

def second
  garbage_values = []
  open_groups = []
  state = :reading

  input.each do |chr|
    if state == :ignoring
      state = :garbage
      next
    end

    case chr
    when '{'
      if state == :reading
        open_groups.push chr
      elsif state == :garbage
        garbage_values << chr
      end
    when '}'
      if state == :reading
        open_groups.pop
      elsif state == :garbage
        garbage_values << chr
      end
    when '<'
      if state == :reading
        state = :garbage
      elsif state == :garbage
        garbage_values << chr
      end
    when '>'
      if state == :garbage
        state = :reading
      end
    when '!'
      if state == :garbage
        state = :ignoring
      end
    else
      if state == :garbage
        garbage_values << chr
      end
    end
  end

  # 8828 too high
  garbage_values.count
end

def input
  open('inputs/y2017/day_nine.txt').map(&:chomp).first.split('')
end
