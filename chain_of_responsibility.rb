def pp(str)
  p str
  sleep(2)
end

class Terminal
  def initialize
    pp '- Hello! What do you want?'

    pp '- Hi, i need 9999999 bucks'

    pp '- Sorry but i cant give you so large amount . May you wanna call employee?'

    pp '- Yes'

    pp 'Beep... beep...'

    pp '...'
    Employer.new
  end
end

class Employer
  def initialize
    pp '- Hi! I am employee. What do you want?'

    pp '- Hi, i need 9999999 bucks'

    pp '- Sorry but i cant give you so large amount. May you wanna call our director?'

    pp '- Yes'

    pp '- Okay, one minute i calling'

    pp '...'
    Director.new
  end
end

class Director
  def initialize
    pp '- Hi! I am director of this bank. What do you want?'

    pp '- Hi, i need 9999999 bucks'

    pp '- Do know that you will need return this money back?'

    pp '- No :('

    pp '- Bye'
  end
end

Terminal.new
