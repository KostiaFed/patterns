class Builder
  attr_reader :roof, :walls, :foundation

  def initialize
    p 'Start house building'
    foundation = Foundation.build('beton')
    walls = Walls.build('bricks')
    roof = Roof.build('green')
    p 'Building successfully finished'
  end
end

class Foundation
  def self.build(str)
    p str + ' foundation installed'
  end
end

class Walls
  def self.build(str)
    p str + ' walls installed'
  end
end

class Roof
  def self.build(str)
    p str + ' roof installed'
  end
end

Builder.new
