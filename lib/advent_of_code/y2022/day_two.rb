POINTS_WIN = 6
POINTS_DRAW = 3
POINTS_LOSE = 0

POINTS_ROCK = 1
POINTS_PAPER = 2
POINTS_SCISSOR = 3

ROCK_OP = 'A'
PAPER_OP = 'B'
SCISSOR_OP = 'C'

LOSE_ME = ROCK_ME = 'X'
DRAW_ME = PAPER_ME = 'Y'
WIN_ME = SCISSOR_ME = 'Z'

def first
  input.map do |op, you|
    case op
    when ROCK_OP # Rock
      case you
      when ROCK_ME # Rock
        POINTS_ROCK + POINTS_DRAW
      when PAPER_ME # Paper
        POINTS_PAPER + POINTS_WIN
      when SCISSOR_ME # Scissor
        POINTS_SCISSOR + POINTS_LOSE
      end
    when  PAPER_OP # Paper
      case you
      when ROCK_ME # Rock
        POINTS_ROCK + POINTS_LOSE
      when PAPER_ME # Paper
        POINTS_PAPER + POINTS_DRAW
      when SCISSOR_ME # Scissor
        POINTS_SCISSOR + POINTS_WIN
      end
    when  SCISSOR_OP # Scissor
      case you
      when ROCK_ME # Rock
        POINTS_ROCK + POINTS_WIN
      when PAPER_ME # Paper
        POINTS_PAPER + POINTS_LOSE
      when SCISSOR_ME # Scissor
        POINTS_SCISSOR + POINTS_DRAW
      end
    end
  end.sum
end

def second
  input.map do |op, you|
    case op
    when ROCK_OP # Rock
      case you
      when LOSE_ME # Lose
        POINTS_SCISSOR + POINTS_LOSE # Need Scissor
      when DRAW_ME # Draw
        POINTS_ROCK + POINTS_DRAW # Need Rock
      when WIN_ME # Win
        POINTS_PAPER + POINTS_WIN # Need Paper
      end
    when  PAPER_OP # Paper
      case you
      when LOSE_ME # Lose
        POINTS_ROCK + POINTS_LOSE
      when DRAW_ME # Draw
        POINTS_PAPER + POINTS_DRAW
      when WIN_ME # Win
        POINTS_SCISSOR + POINTS_WIN
      end
    when  SCISSOR_OP # Scissor
      case you
      when LOSE_ME # Lose
        POINTS_PAPER + POINTS_LOSE
      when DRAW_ME # Draw
        POINTS_SCISSOR + POINTS_DRAW
      when WIN_ME # Win
        POINTS_ROCK + POINTS_WIN
      end
    end
  end.sum
end

def input
  open('inputs/y2022/day_two.txt').map(&:chomp).map { |line| line.split(' ') }
end
