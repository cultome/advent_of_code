def first
  generate_combinations.each_with_object([]) do |comb, acc|
    game_stats = my_stats.clone
    game_boss = boss_stats.clone

    money_spend = buy_stuff game_stats, comb
    winner = play game_stats, game_boss

    if winner == :me
      acc << money_spend
    end
  end.min
end

def second
  generate_combinations.each_with_object([]) do |comb, acc|
    game_stats = my_stats.clone
    game_boss = boss_stats.clone

    money_spend = buy_stuff game_stats, comb
    winner = play game_stats, game_boss

    if winner == :boss
      acc << money_spend
    end
  end.max
end

def generate_combinations
  rings_comb = rings_shop.keys.permutation(2).to_a + rings_shop.keys.map { |arr| [arr] }
  weapons_comb = weapon_shop.keys.map { |arr| [arr] }
  armors_comb = armor_shop.keys.map { |arr| [arr] }

  all_combs = []
  weapons_comb.each do |weapon|
    all_combs << weapon
    armors_comb.each do |armor|
      all_combs << weapon + armor
      rings_comb.each do |rings|
        all_combs << rings + weapon
        all_combs << rings + weapon + armor
      end
    end
  end

  all_combs
end

def boss_stats
  {
    hit_points: 104,
    damage: 8,
    armor: 1,
  }
end

def my_stats
  {
    hit_points: 100,
    damage: 0,
    armor: 0,
  }
end

def buy_stuff(me, comb)
  comb.reduce(0) do |acc, item|
    item_stats = shop[item]
    me[:damage] += item_stats[:damage]
    me[:armor] += item_stats[:armor]
    acc + item_stats[:cost]
  end
end

def play(me, boss)
  loop do
    deal_damage me, boss
    return :me if boss[:hit_points] <= 0

    deal_damage boss, me
    return :boss if me[:hit_points] <= 0
  end
end

def deal_damage(a, b)
  damage_dealt = a[:damage] - b[:armor]
  damage_dealt = damage_dealt > 1 ? damage_dealt : 1
  b[:hit_points] -= damage_dealt
end

def shop
  @shop ||= weapon_shop.merge(armor_shop, rings_shop)
end

def weapon_shop
  @weapon_shop ||= {
    'Dagger' => { cost: 8, damage: 4, armor: 0},
    'Shortswor' => { cost: 10, damage: 5, armor: 0},
    'Warhammer' => { cost: 25, damage: 6, armor: 0},
    'Longsword' => { cost: 40, damage: 7, armor: 0},
    'Greataxe' => { cost: 74, damage: 8, armor: 0},
  }
end

def armor_shop
  @armor_shop ||= {
    'Leather' => { cost: 13, damage: 0, armor: 1},
    'Chainmail' => { cost: 31, damage: 0, armor: 2},
    'Splintmai' => { cost: 53, damage: 0, armor: 3},
    'Bandedmai' => { cost: 75, damage: 0, armor: 4},
    'Platemai' => { cost: 102, damage: 0, armor: 5},
  }
end

def rings_shop
  @rings_shop ||= {
    'Damage+1' => { cost: 25, damage: 1, armor: 0},
    'Damage+2' => { cost: 50, damage: 2, armor: 0},
    'Damage+3' => { cost: 100, damage: 3, armor: 0},
    'Defense+1' => { cost: 20, damage: 0, armor: 1},
    'Defense+2' => { cost: 40, damage: 0, armor: 2},
    'Defense+3' => { cost: 80, damage: 0, armor: 3},
  }
end
