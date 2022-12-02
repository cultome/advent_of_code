def first
  input.map do |op, you|
    case op
    when 'A' # Rock
      case you
      when 'X' # Rock
        1 + 3
      when 'Y' # Paper
        2 + 6
      when 'Z' # Scissor
        3 + 0
      end
    when 'B' # Paper
      case you
      when 'X' # Rock
        1 + 0
      when 'Y' # Paper
        2 + 3
      when 'Z' # Scissor
        3 + 6
      end
    when 'C' # Scissor
      case you
      when 'X' # Rock
        1 + 6
      when 'Y' # Paper
        2 + 0
      when 'Z' # Scissor
        3 + 3
      end
    end
  end.sum
end

def second
  input.map do |op, you|
    case op
    when 'A' # Rock
      case you
      when 'X' # Lose
        3 + 0 # Need Scissor
      when 'Y' # Draw
        1 + 3 # Need Rock
      when 'Z' # Win
        2 + 6 # Need Paper
      end
    when 'B' # Paper
      case you
      when 'X' # Lose
        1 + 0
      when 'Y' # Draw
        2 + 3
      when 'Z' # Win
        3 + 6
      end
    when 'C' # Scissor
      case you
      when 'X' # Lose
        2 + 0
      when 'Y' # Draw
        3 + 3
      when 'Z' # Win
        1 + 6
      end
    end
  end.sum
end

def input
  open('inputs/y2022/day_two.txt').map(&:chomp).map { |line| line.split(' ') }
end
