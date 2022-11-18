require 'digest'

def first
  salt = 'ahsbgdzn'
  extra = 0
  keys = []

  loop do
    break if keys.size >= 64

    md5 = Digest::MD5.hexdigest "#{salt}#{extra}"
    extra += 1

    if md5 =~ /(.)\1\1/
      char = $1
      quintuple = Regexp.new "#{char * 5}"
      extra_nested = extra + 1

      loop do
        break if extra_nested - extra > 1_000

        md5_2 = Digest::MD5.hexdigest "#{salt}#{extra_nested}"
        extra_nested += 1

        if md5_2 =~ quintuple
          keys << extra - 1
          break
        end
      end
    end
  end

  keys.last
end

def second
  salt = 'ahsbgdzn'
  extra = 0
  keys = []
  stretch = 2_016

  loop do
    print "#{extra}            \r"
    break if keys.size >= 64

    md5 = Digest::MD5.hexdigest "#{salt}#{extra}"
    stretch.times do
      md5 = Digest::MD5.hexdigest md5
    end

    if md5 =~ /(.)\1\1/
      char = $1
      quintuple = Regexp.new "#{char * 5}"
      extra_nested = extra + 1

      loop do
        break if extra_nested - extra > 1_000

        md5_2 = Digest::MD5.hexdigest "#{salt}#{extra_nested}"
        stretch.times do
          md5_2 = Digest::MD5.hexdigest md5_2
        end

        if md5_2 =~ quintuple
          keys << extra
          break
        end

        extra_nested += 1
      end
    end

    extra += 1
  end

  keys.last
end
