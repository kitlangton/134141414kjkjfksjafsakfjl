class Weapon

  attr_reader :name, :damage

  def initialize(name, damage = 20)
    raise ArgumentError unless name.is_a? String
    raise ArgumentError unless damage.is_a? Integer
    @name = name
    @damage = damage
  end

  def bot=(battle_bot)
    raise ArgumentError unless battle_bot.nil? || battle_bot.is_a?(BattleBot)
    @bot = battle_bot
  end

  def bot
    @bot
  end

  def picked_up?
    !!@bot
  end

end
