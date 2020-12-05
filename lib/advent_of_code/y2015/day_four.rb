require 'digest'

def first
  mine 'iwrupvqb', '00000'
end

def second
  mine 'iwrupvqb', '000000'
end

def mine(seed, target)
  idx = 1

  loop do
    hash = Digest::MD5.hexdigest "#{seed}#{idx}"

    return idx if hash.start_with? target

    idx += 1
  end
end
