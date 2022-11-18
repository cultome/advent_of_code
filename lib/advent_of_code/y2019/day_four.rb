def first
  calculate_passwords.size
end

def second
  passwords = calculate_passwords.select do |digits|
    digits.group_by { |n| n }.values.map(&:size).any? { |size| size == 2 }
  end

  passwords.size
end

def calculate_passwords
  (235741..706948).reduce([]) do |acc, num|
    digits = num.to_s.split("").map(&:to_i)

    if digits.reduce(0) { |acc, n| acc.nil? ? nil : n >= acc ? n : nil }
      if !digits.group_by { |n| n }.values.map(&:size).select { |size| size >= 2 }.empty?
        acc << digits
      end
    end

    acc
  end
end
