class BattleBot

  attr_reader :name, :health, :enemies, :weapon

  @@count = 0

  def self.count
    @@count
  end

  def initialize(name)
    @name = name
    @health = 100
    @enemies = []
    @weapon = nil
    @alive = true
    @@count += 1
  end

  def dead?
    @health <= 0
  end

  def has_weapon?
    !!@weapon
  end

  def pick_up(weapon)
    raise ArgumentError unless weapon.is_a? Weapon
    raise ArgumentError if weapon.picked_up?
    return if has_weapon?

    weapon.bot = self
    @weapon = weapon
  end

  def drop_weapon
    @weapon.bot = nil
    @weapon = nil
  end

  def take_damage(damage)
    raise ArgumentError unless damage.is_a? Fixnum
    @health -= damage
    if @health < 0
      @health = 0
      @@count -= 1
    end
    @health
  end

  def heal
    @health += 10 unless dead?
    @health = 100 if @health > 100
    @health
  end

  def attack(enemy_bot)
    raise ArgumentError unless enemy_bot.is_a? BattleBot
    raise ArgumentError if enemy_bot == self
    raise ArgumentError unless has_weapon?
    enemy_bot.receive_attack_from(self)
  end

  def receive_attack_from(enemy_bot)
    raise ArgumentError unless enemy_bot.is_a? BattleBot
    raise ArgumentError if enemy_bot == self
    raise ArgumentError unless enemy_bot.has_weapon?

    take_damage(enemy_bot.weapon.damage)
    @enemies << enemy_bot unless @enemies.include?(enemy_bot)
    defend_against(enemy_bot)
  end

  def defend_against(enemy_bot)
    return if dead? || !has_weapon?
    attack(enemy_bot)
  end
end
