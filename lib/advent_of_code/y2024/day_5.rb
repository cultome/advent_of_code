def first
  choose(*input).map { |pages| pages[pages.size / 2] }.sum
end

def second
  rules, updates = input
  invalids = choose rules, updates, valids: false

  fixed = invalids.map do |pages|
    tmp = pages.clone

    pages.each do |page|
      apply_rules = rules.select { |a, b| a == page && tmp.include?(b) }

      next if apply_rules.empty?

      apply_rules.each do |before, after|
        page_idx = tmp.index before
        limit_idx = tmp.index after

        next if page_idx < limit_idx

        tmp.delete_at page_idx
        tmp.insert limit_idx, before
      end
    end

    tmp
  end

  fixed.map { |pages| pages[pages.size / 2] }.sum
end

def input
  a, b = open('inputs/y2024/day_5.txt').map(&:chomp).slice_when { |_a, b| b.empty? }.map(&:to_a)

  [
    a.map { |l| l.split('|').map(&:to_i) },
    b[1..].map { |l| l.split(',').map(&:to_i) },
  ]
end

def choose(rules, updates, valids: true)
  updates.select do |pages|
    is_valid = valid? pages, rules
    valids ? is_valid : !is_valid
  end
end

def valid?(pages, rules)
  rules.all? do |before, after|
    before_idx = pages.index before
    after_idx = pages.index after

    before_idx.nil? || after_idx.nil? || before_idx < after_idx
  end
end
