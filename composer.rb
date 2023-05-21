require 'pry'

class Soldier
  attr_accessor :role

  def initialize(role)
    self.role = role
  end
end

class Army
  attr_accessor :army

  def initialize
    self.army = create_army
    p 'Army successfully created'
  end

  def create_army
    privates = [Soldier.new('Private1'), Soldier.new('Private2'), Soldier.new('Private3'), Soldier.new('Private4')]
    squad = Formation.new(Soldier.new('Officer'), privates, nil, 'squad')
    squadron = Formation.new(Soldier.new('Centurion'), nil, [squad], 'squadron')
    regiment = Formation.new(Soldier.new('Colonel'), nil, [squadron], 'regiment')
    Formation.new(Soldier.new('General'), nil, [regiment], 'army')
  end

  def count_of_army
    p 'Army size: ' + army.count.to_s
  end
end

class Formation
  attr_accessor :commander, :soldiers, :subsidiary, :name

  def initialize(commander, soldiers, subsidiary, name)
    self.commander = commander
    self.soldiers = soldiers
    self.subsidiary = subsidiary
    self.name = name
  end

  def count
    count = 0
    count += 1 unless commander.nil?
    count += soldiers.size unless soldiers.nil?
    subsidiary.each { |s| count += s.count } unless subsidiary.nil?
    count
  end
end

Army.new.count_of_army
