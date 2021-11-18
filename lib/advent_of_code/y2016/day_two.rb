def first
  keypad = {
    1 => { up: 1, right: 2, down: 4, left: 1 },
    2 => { up: 2, right: 3, down: 5, left: 1 },
    3 => { up: 3, right: 3, down: 6, left: 2 },

    4 => { up: 1, right: 5, down: 7, left: 4 },
    5 => { up: 2, right: 6, down: 8, left: 4 },
    6 => { up: 3, right: 6, down: 9, left: 5 },

    7 => { up: 4, right: 8, down: 7, left: 7 },
    8 => { up: 5, right: 9, down: 8, left: 7 },
    9 => { up: 6, right: 9, down: 9, left: 8 },
  }

  key = 5
  input.map do |seq|
    seq.each do |move|
      key = keypad[key][move]
    end

    key
  end.join()
end

def second
    #1
  #2 3 4
#5 6 7 8 9
  #A B C
    #D

  keypad = {
    '1' => { up: '1', right: '1', down: '3', left: '1' },
    '2' => { up: '2', right: '3', down: '6', left: '2' },
    '3' => { up: '1', right: '4', down: '7', left: '2' },
    '4' => { up: '4', right: '4', down: '8', left: '3' },
    '5' => { up: '5', right: '6', down: '5', left: '5' },
    '6' => { up: '2', right: '7', down: 'A', left: '5' },
    '7' => { up: '3', right: '8', down: 'B', left: '6' },
    '8' => { up: '4', right: '9', down: 'C', left: '7' },
    '9' => { up: '9', right: '9', down: '9', left: '8' },
    'A' => { up: '6', right: 'B', down: 'A', left: 'A' },
    'B' => { up: '7', right: 'C', down: 'D', left: 'A' },
    'C' => { up: '8', right: 'C', down: 'C', left: 'B' },
    'D' => { up: 'B', right: 'D', down: 'D', left: 'D' },
  }

  key = '5'
  input.map do |seq|
    seq.each do |move|
      key = keypad[key][move]
    end

    key
  end.join()
end

def input
  open('inputs/y2016/day_two.txt').map(&:chomp).map do |line|
    line.split('').map do |letter|
      case letter
      when 'U' then :up
      when 'R' then :right
      when 'D' then :down
      when 'L' then :left
      end
    end
  end
end
