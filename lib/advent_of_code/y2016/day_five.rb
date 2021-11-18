require 'digest'

def first
  door_id = "cxdnnyjw"
  ounce = 1
  password = ""

  loop do
    hash = Digest::MD5.hexdigest "#{door_id}#{ounce}"
    password << hash[5] if hash.start_with? '00000'

    break if password.size >= 8

    ounce += 1
  end

  password
end

def second
  door_id = "cxdnnyjw"
  ounce = 1
  password = "        "
  valid_idxs = %w[0 1 2 3 4 5 6 7]

  loop do
    hash = Digest::MD5.hexdigest "#{door_id}#{ounce}"

    if hash.start_with?('00000') && valid_idxs.include?(hash[5]) && password[hash[5].to_i] == ' '
      password[hash[5].to_i] = hash[6]
    end

    break unless password.include?(' ')

    ounce += 1
  end

  password
end

def input
  open('inputs/y2016/day_five.txt').map(&:chomp)
end
