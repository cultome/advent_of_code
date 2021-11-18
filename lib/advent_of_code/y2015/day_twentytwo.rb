def first
  me = {
    hit_points: 50,
    mana_points: 500,
    armor: 0,
  }

  boss = {
    hit_points: 55,
    damage: 8,
  }

  moves = Move.new
  results = []
  top_limit = 1_000

  loop do
    status, mana_spend, msg, move = play! me.clone, boss.clone, moves, top_limit

    if status == :win
      top_limit = mana_spend if mana_spend < top_limit

      results << mana_spend
    elsif status == :finish
      break
    end
  end

  results.min
end

def second
  me = {
    hit_points: 50,
    mana_points: 500,
    armor: 0,
  }

  boss = {
    hit_points: 55,
    damage: 8,
  }

  moves = Move.new
  results = []
  top_limit = 1_400

  loop do
    status, mana_spend, msg, move = play! me.clone, boss.clone, moves, top_limit, true

    if status == :win
      top_limit = mana_spend if mana_spend < top_limit
      results << mana_spend
    elsif status == :finish
      break
    end
  end

  results.min
end

def check_precondition(me, cost, spell, move, effects)
  if me[:mana_points] < cost
    move.viable = false
    return 'Out of mana'
  end

  if effects.find { |fx| fx[:name] == spell && fx[:turns_left] > 0 }
    move.viable = false
    return 'Effect in progress'
  end
end

def play!(me, boss, moves, top_limit, is_hard = false)
  total_mana_used = 0
  effects = []
  current_move = moves

  loop do
    # player_turn
    if is_hard
      me[:hit_points] -= 1

      if me[:hit_points] <= 0
        current_move.viable = false
        return [:lose, total_mana_used, 'you died hard', current_move]
      end
    end

    start_of_turn me, boss, effects
    old_move, current_move = current_move, current_move.next_move

    if old_move == current_move || current_move.nil?
      return [:finish, total_mana_used, 'No more moves', current_move]
    end

    case current_move.decision
    when :magic_missile # magic_missile costs 53 mana. does 4 damage.
      fail_msg = check_precondition me, 53, :magic_missile, current_move, effects
      return [:lose, total_mana_used, fail_msg, current_move] unless fail_msg.nil?

      me[:mana_points] -= 53
      total_mana_used += 53

      boss[:hit_points] -= 4
    when :drain # drain costs 73 mana. does 2 damage and heals you for 2 hit points.
      fail_msg = check_precondition me, 73, :drain, current_move, effects
      return [:lose, total_mana_used, fail_msg, current_move] unless fail_msg.nil?

      me[:mana_points] -= 73
      total_mana_used += 73

      boss[:hit_points] -= 2
      me[:hit_points] += 2
    when :shield # shield costs 113 mana. lasts for 6 turns. your armor is increased by 7.
      fail_msg = check_precondition me, 113, :shield, current_move, effects
      return [:lose, total_mana_used, fail_msg, current_move] unless fail_msg.nil?

      me[:mana_points] -= 113
      total_mana_used += 113

      effects << { name: :shield, turns_left: 6, applied: false }
    when :poison # poison costs 173 mana. lasts for 6 turns. deals the boss 3 damage.
      fail_msg = check_precondition me, 173, :poison, current_move, effects
      return [:lose, total_mana_used, fail_msg, current_move] unless fail_msg.nil?

      me[:mana_points] -= 173
      total_mana_used += 173

      effects << { name: :poison, turns_left: 6, applied: false }
    when :recharge # recharge costs 229 mana. lasts for 5 turns. gives you 101 new mana.
      fail_msg = check_precondition me, 229, :recharge, current_move, effects
      return [:lose, total_mana_used, fail_msg, current_move] unless fail_msg.nil?

      me[:mana_points] -= 229
      total_mana_used += 229

      effects << { name: :recharge, turns_left: 5, applied: false }
    end

    # check win condition
    if boss[:hit_points] <= 0
      current_move.success = true
      current_move.viable = false
      return [:win, total_mana_used, 'killed the boss', current_move]
    end

    # boss_turn
    start_of_turn me, boss, effects
    me[:hit_points] -= [boss[:damage] - me[:armor], 1].max

    # check win condition
    if me[:hit_points] <= 0
      current_move.viable = false
      return [:lose, total_mana_used, 'you died', current_move]
    end

    if total_mana_used >= top_limit
      current_move.viable = false
      return [:abort, total_mana_used, 'exceed mana limit', current_move]
    end
  end
end

def start_of_turn(me, boss, effects)
  effects.select { |fx| fx[:turns_left] > 0 }.each do |fx|
    case fx[:name]
    when :shield
      if !fx[:applied]
        fx[:applied] = true
        me[:armor] += 7
      end
    when :poison
      fx[:applied] = true
      boss[:hit_points] -= 3
    when :recharge
      fx[:applied] = true
      me[:mana_points] += 101
    end

    fx[:turns_left] -= 1
  end

  effects.select { |fx| fx[:turns_left] <= 0 }.each do |fx|
    case fx[:name]
    when :shield
      me[:armor] -= 7
    end
  end

  effects.delete_if { |fx| fx[:turns_left] <= 0 }
end

class Move
  attr_accessor :decision, :parent, :viable, :success, :mana_points, :options

  def initialize(decision = nil, parent = nil)
    @decision = decision
    @parent = parent

    @viable = true
    @success = false
    @mana_points = 0
  end

  def next_move
    init_options

    if !viable
      return nil if parent.nil?
      return parent.next_move
    else
      opt = options.find(&:viable)

      if opt.nil?
        @viable = false
        return nil if parent.nil?
        return parent.next_move
      else
        opt
      end
    end
  end

  def init_options
    @options ||= [
      Move.new(:magic_missile, self),
      Move.new(:drain, self),
      Move.new(:shield, self),
      Move.new(:poison, self),
      Move.new(:recharge, self),
    ]
  end

  def inspect
    if parent.nil?
      "ROOT"
    else
      "#{parent.inspect} -> #{decision}"
    end
  end
end
