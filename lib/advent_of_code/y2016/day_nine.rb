def first
  input.map { |line| decompres line }.map(&:size).first
end

def second
  input.map { |line| decompres_v2 line }.first
end

def decompres_v2(line)
  result = 0

  while (idx = line.index /(\([\d]+x[\d]+\))/)
    marker_size = $1.size
    chars, repetitions = $1[1..-2].split('x').map(&:to_i)

    result += line[0...idx].size
    content = line[idx+marker_size, chars]

    if content.index /(\([\d]+x[\d]+\))/
      content_size = decompres_v2 content
    else
      content_size = content.size
    end

    result += content_size * repetitions

    line = line[idx + marker_size + chars..]
  end

  result + line.size
end

def decompres(line)
  result = ""

  while (idx = line.index /(\([\d]+x[\d]+\))/)
    marker_size = $1.size
    chars, repetitions = $1[1..-2].split('x').map(&:to_i)

    result << line[0...idx]
    content = line[idx+marker_size, chars]

    repetitions.times do
      result << content
    end

    line = line[idx + marker_size + chars..]
  end

  result + line
end

def input
  open('inputs/y2016/day_nine.txt').map(&:chomp)
end
