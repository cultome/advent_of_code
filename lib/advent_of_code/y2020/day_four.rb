def first
  valid_records.size
end

def second
  valid_records.count do |record|
    record.all? do |key, value|
      case key
      when 'byr' # (Birth Year) - four digits; at least 1920 and at most 2002.
        value.to_i >= 1920 && value.to_i <= 2002
      when 'iyr' # (Issue Year) - four digits; at least 2010 and at most 2020.
        value.to_i >= 2010 && value.to_i <= 2020
      when 'eyr' # (Expiration Year) - four digits; at least 2020 and at most 2030.
        value.to_i >= 2020 && value.to_i <= 2030
      when 'hgt' # (Height) - a number followed by either cm or in:
        if value.end_with? 'cm'
          # If cm, the number must be at least 150 and at most 193.
          value.gsub('cm', '').to_i >= 150 && value.gsub('cm', '').to_i <= 193
        elsif value.end_with? 'in'
          # If in, the number must be at least 59 and at most 76.
          value.gsub('in', '').to_i >= 59 && value.gsub('in', '').to_i <= 76
        else
          false
        end
      when 'hcl' # (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
        value =~ /^#[\w]{6}$/
      when 'ecl' # (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
        value =~ /^(amb|blu|brn|gry|grn|hzl|oth)$/
      when 'pid' # (Passport ID) - a nine-digit number, including leading zeroes.
        value =~ /^[\d]{9}$/
      when 'cid' # (Country ID) - ignored, missing or not.
        true
      else
        false
      end
    end
  end
end

def valid_records
  required_fields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']

  input.select { |record| required_fields.all? { |key| record.key? key } }
end

def input
  File.read('inputs/y2020/day_four.txt').
    split("\n\n").
    map { |line| line.split(/[\n ]/) }.
    each_with_object([]) do |arr, res|
      res << arr.each_with_object({})do |field, acc|
        k, v = field.split(':')
        acc[k] = v
      end
    end
end
