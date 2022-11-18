require 'digest'

def first
  @passcode = 'dmypynyp'
  results = walk genmd5(''), '', [0, 0]
  min = results.map(&:size).min
  results.find { |path| path.size == min }
end

def second
  @passcode = 'dmypynyp'
  results = walk genmd5(''), '', [0, 0]
  results.map(&:size).max
end

def walk(md5, path, pos)
  return [path] if pos == [3, 3]

  results = []
  open_door = %w[b c d e f]
  up, down, left, right = md5.split('').map { |l| open_door.include? l }

  results.concat walk(genmd5(path + 'U'), path + 'U', [pos.first, pos.last - 1]) if up && pos.last - 1 >= 0
  results.concat walk(genmd5(path + 'R'), path + 'R', [pos.first + 1, pos.last]) if right && pos.first + 1 < 4
  results.concat walk(genmd5(path + 'D'), path + 'D', [pos.first, pos.last + 1]) if down && pos.last + 1 < 4
  results.concat walk(genmd5(path + 'L'), path + 'L', [pos.first - 1, pos.last]) if left && pos.first - 1 >= 0

  results.flatten
end

def genmd5(path)
  Digest::MD5.hexdigest([@passcode, path].join)[0...4]
end
