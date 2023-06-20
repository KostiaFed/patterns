class Ciphrator
  lit_al = %W[
    A a
    B b
    C c
    D d
    E e
    F f
    G g
    H h
    I i
    J j
    K k
    L l
    M m
    N n
    O o
    P p
    Q q
    R r
    S s
    T t
    U u
    V v
    W w
    X x
    Y y
    Z z
    \u0410 \u0430
    \u0411 \u0431
    \u0412 \u0432
    \u0413 \u0433
    \u0490 \u0491
    \u0414 \u0434
    \u0415 \u0435
    \u0404 \u0454
    \u0416 \u0436
    \u0417 \u0437
    \u0418 \u0438
    \u0406 \u0456
    \u0407 \u0457
    \u0419 \u0439
    \u041A \u043A
    \u041B \u043B
    \u041C \u043C
    \u041D \u043D
    \u041E \u043E
    \u041F \u043F
    \u0420 \u0440
    \u0421 \u0441
    \u0422 \u0442
    \u0423 \u0443
    \u0424 \u0444
    \u0425 \u0445
    \u0426 \u0446
    \u0427 \u0447
    \u0428 \u0448
    \u0429 \u0449
    \u042C \u044C
    \u042E \u044E
    \u042F \u044F
  ]

  add_s = [
    '§', '±',
    '!', '1',
    '2', '@',
    '#', '3',
    '4', '$',
    '%', '5',
    '6', '^',
    '*', '8',
    '9', '(',
    ')', '0',
    '+', '=',
    '}', '{',
    '[', ']',
    '|', '\\',
    '\'', '"',
    '<', '>',
    '?', '/',
    '.', ',',
    '-', '_',
    ' ', '~',
    '`', '₴',
    "\n", '&',
    '7', '№'
  ]

  ALFABETS = (lit_al + add_s).to_a

  def self.clear_chiphered
    aFile = File.new('ciphered', 'w+')
    aFile.close
  end

  def self.read_file(to_cipher_file)
    IO.foreach(to_cipher_file) do |block|
      puts block
    end
  end

  def self.puts_one_block(block)
    aFile = File.new('ciphered', 'a+')
    puts block
    aFile.syswrite(block) if aFile
    aFile.close
  end

  def self.cesar_ciph(to_cipher_file, step)
    clear_chiphered

    IO.foreach(to_cipher_file) do |block|
      str_temp = ''
      block.split('').each do |s|
        v = ALFABETS.index(s)
        str_temp += if v + step * 2 < ALFABETS.size
                      ALFABETS[v + step * 2]
                    else
                      ALFABETS[(v + step * 2) - ALFABETS.size]
                    end
      end
      puts_one_block(str_temp)
    end
  end

  def self.alter_ciph(to_cipher_file, alternative_alfabet)
    clear_chiphered

    IO.foreach(to_cipher_file) do |block|
      str_temp = ''
      block.split('').each do |s|
        str_temp += if alternative_alfabet[s.upcase.to_sym].nil?
                      s
                    else
                      alternative_alfabet[s.upcase.to_sym]
                    end
      end
      puts_one_block(str_temp)
    end
  end

  def self.cesar_deciph(step)
    IO.foreach('ciphered') do |block|
      str_temp = ''
      block.split('').each do |s|
        v = ALFABETS.index(s)
        str_temp += if v - step * 2 < ALFABETS.size
                      ALFABETS[v - step * 2]
                    else
                      ALFABETS[(v - step * 2) - ALFABETS.size]
                    end
      end
      puts str_temp
    end
  end

  def self.alter_deciph(alternative_alfabet)
    IO.foreach('ciphered') do |block|
      str_temp = ''
      block.split('').each do |s|
        str_temp += if alternative_alfabet.key(s.upcase).nil?
                      s
                    else
                      alternative_alfabet.key(s.upcase).to_s
                    end
      end
      puts str_temp
    end
  end

  def self.two_alter_deciph(alternative_alfabet)
    IO.foreach('ciphered') do |block|
      str_temp = ''
      second = false
      s = ''
      block.split('').each do |ss|
        if ss != '1' && ss != '0' && second == false
          str_temp += ss
        elsif second
          s += ss
          second = false
          str_temp += if alternative_alfabet.key(s.upcase).nil?
                        s
                      else
                        alternative_alfabet.key(s.upcase).to_s
                      end
          s = ''
        else
          s += ss
          second = true
        end
      end
      puts str_temp
    end
  end

  def self.two_i_alter_deciph(alternative_alfabet, literal = false)
    IO.foreach('ciphered') do |block|
      str_temp = ''
      second = false
      s = ''
      block.split('').each do |ss|
        if (is_numeric?(ss) == false && literal == false) || (is_literal?(ss) == false && literal == true)
          str_temp += ss
        elsif second
          s += ss
          second = false
          str_temp += if alternative_alfabet.key(s.upcase).nil?
                        s
                      else
                        alternative_alfabet.key(s.upcase).to_s
                      end
          s = ''
        else
          s += ss
          second = true
        end
      end
      puts str_temp
    end
  end

  def self.square_to_common(square)
    hash = {}
    row_i = 0
    square.each do |row|
      row_i += 1
      column_i = 0
      row.each do
        column_i += 1
        hash[(square[row_i - 1][column_i - 1]).to_sym] = column_i.to_s + row_i.to_s
      end
    end
    hash
  end

  def self.square_with_nums_to_common(square)
    hash = {}
    row_i = 0
    first_row = []
    square.each do |row|
      row_i += 1
      column_i = 0
      first_column = ''
      if row_i == 1
        first_row = row
      else
        row.each do |column|
          column_i += 1
          if column_i == 1
            first_column = column
          else
            hash[(square[row_i - 1][column_i - 1]).to_sym] = first_column + first_row[column_i - 1]
          end
        end
      end
    end
    hash
  end

  def self.size
    ALFABETS.size
  end

  def self.is_numeric?(obj)
    obj.to_s.match(/\d/).nil? ? false : true
  end

  def self.is_literal?(obj)
    obj.to_s.match(/[A-z]/).nil? ? false : true
  end
end

alternative_alfabet = {
  'A': 'K',
  'B': 'H',
  'C': 'R',
  'D': 'Z',
  'E': 'X',
  'F': 'I',
  'G': 'N',
  'H': 'A',
  'I': 'P',
  'J': 'L',
  'K': 'U',
  'L': 'Q',
  'M': 'D',
  'N': 'F',
  'O': 'S',
  'P': 'T',
  'Q': 'Y',
  'R': 'B',
  'S': 'E',
  'T': 'W',
  'U': 'J',
  'V': 'V',
  'W': 'C',
  'X': 'G',
  'Y': 'M',
  'Z': 'O'
}

two_char_alfabet = {
  'A': '0M',
  'B': '0N',
  'C': '1O',
  'D': '1P',
  'E': '1Q',
  'F': '0R',
  'G': '1S',
  'H': '0T',
  'I': '1U',
  'J': '1W',
  'K': '0X',
  'L': '1Y',
  'M': '0Z',
  'N': '1A',
  'O': '0B',
  'P': '0C',
  'Q': '1D',
  'R': '1E',
  'S': '1F',
  'T': '1G',
  'U': '0H',
  'V': '0V',
  'W': '0I',
  'X': '0J',
  'Y': '0K',
  'Z': '0L'
}

alternative_symb_alfabet = {
  'A': '!',
  'B': '№',
  'C': '%',
  'D': '+',
  'E': '-',
  'F': '/',
  'G': '<',
  'H': '>',
  'I': '=',
  'J': '*',
  'K': '(',
  'L': ')',
  'M': '{',
  'N': '[',
  'O': ']',
  'P': '}',
  'Q': '1',
  'R': '2',
  'S': '3',
  'T': '4',
  'U': '5',
  'V': 'V',
  'W': '6',
  'X': '7',
  'Y': '8',
  'Z': '9'
}

two_integer_alfabet = {
  'A': '12',
  'B': '14',
  'C': '16',
  'D': '18',
  'E': '19',
  'F': '22',
  'G': '23',
  'H': '26',
  'I': '27',
  'J': '29',
  'K': '31',
  'L': '32',
  'M': '37',
  'N': '35',
  'O': '33',
  'P': '30',
  'Q': '29',
  'R': '25',
  'S': '24',
  'T': '21',
  'U': '20',
  'V': '10',
  'W': '17',
  'X': '15',
  'Y': '13',
  'Z': '11'
}

square = [
  %w[A B C D E],
  %w[F G H I J],
  %w[K L M N O],
  %w[P Q R S T],
  %w[U W X Y Z]
]

square_with_nums = [
  %w[. 8 9 0 4 6],
  %w[5 A B C D E],
  %w[4 F G H I J],
  %w[3 K L M N O],
  %w[2 P Q R S T],
  %w[7 U W X Y Z]
]

square_with_lit = [
  %w[. K L U C H],
  %w[N A B C D E],
  %w[O F G H I J],
  %w[F K L M N O],
  %w[X P Q R S T],
  %w[J U W X Y Z]
]

puts ''
puts ''
puts ''
puts '________________1_______________'
puts 'Read text:'
Ciphrator.read_file('to_cipher')
puts ''
puts 'Cesar ciphered text with step 5:'
Ciphrator.cesar_ciph('to_cipher', 5)
puts ''
puts 'Cesar deciphered text with step 5:'
Ciphrator.cesar_deciph(5)
puts '________________________________'
puts ''
puts ''
puts ''
puts '________________2_______________'
puts 'Read text:'
Ciphrator.read_file('to_cipher')
puts ''
puts 'Cesar ciphered text with step -2:'
Ciphrator.cesar_ciph('to_cipher', -2)
puts ''
puts 'Cesar deciphered text with step -2:'
Ciphrator.cesar_deciph(-2)
puts '________________________________'
puts ''
puts ''
puts ''
puts '________________3_______________'
puts 'Read text:'
Ciphrator.read_file('to_cipher')
puts ''
puts 'Ciphered with alterative alfabet:'
Ciphrator.alter_ciph('to_cipher', alternative_alfabet)
puts ''
puts 'Deciphered with alterative alfabet:'
Ciphrator.alter_deciph(alternative_alfabet)
puts '________________________________'
puts ''
puts ''
puts ''
puts '________________4_______________'
puts 'Read text:'
Ciphrator.read_file('to_cipher')
puts ''
puts 'Ciphered with alterative alfabet with integer:'
Ciphrator.alter_ciph('to_cipher', two_char_alfabet)
puts ''
puts 'Deciphered with alterative alfabet with integer:'
Ciphrator.two_alter_deciph(two_char_alfabet)
puts '________________________________'
puts ''
puts ''
puts ''
puts '________________5_______________'
puts 'Read text:'
Ciphrator.read_file('to_cipher')
puts ''
puts 'Ciphered with alterative alfabet:'
Ciphrator.alter_ciph('to_cipher', alternative_symb_alfabet)
puts ''
puts 'Deciphered with alterative alfabet:'
Ciphrator.alter_deciph(alternative_symb_alfabet)
puts '________________________________'
puts ''
puts ''
puts ''
puts '________________6_______________'
puts 'Read text:'
Ciphrator.read_file('to_cipher')
puts ''
puts 'Cesar ciphered text with step equals alfabet center:'
Ciphrator.cesar_ciph('to_cipher', Ciphrator.size / 4)
puts ''
puts 'Cesar deciphered text with step equals alfabet center:'
Ciphrator.cesar_deciph(Ciphrator.size / 4)
puts '________________________________'
puts ''
puts ''
puts ''
puts '________________7_______________'
puts 'Read text:'
Ciphrator.read_file('to_cipher')
puts ''
puts 'Ciphered with alterative integer alfabet:'
Ciphrator.alter_ciph('to_cipher', two_integer_alfabet)
puts ''
puts 'Deciphered with alterative integer alfabet:'
Ciphrator.two_i_alter_deciph(two_integer_alfabet)
puts '________________________________'
puts ''
puts ''
puts ''
puts '________________8_______________'
quare_but_common_alfabet = Ciphrator.square_to_common(square)
puts 'Read text:'
Ciphrator.read_file('to_cipher')
puts ''
puts 'Ciphered with square alfabet:'
Ciphrator.alter_ciph('to_cipher', quare_but_common_alfabet)
puts ''
puts 'Deciphered with square alfabet:'
Ciphrator.two_i_alter_deciph(quare_but_common_alfabet)
puts '________________________________'
puts ''
puts ''
puts ''
puts '________________9_______________'
quare_with_nums_but_common_alfabet = Ciphrator.square_with_nums_to_common(square_with_nums)
puts 'Read text:'
Ciphrator.read_file('to_cipher')
puts ''
puts 'Ciphered with sqauare alfabet with coordinates numbers:'
Ciphrator.alter_ciph('to_cipher', quare_with_nums_but_common_alfabet)
puts ''
puts 'Deciphered with sqauare alfabet with coordinates numbers:'
Ciphrator.two_i_alter_deciph(quare_with_nums_but_common_alfabet)
puts '________________________________'
puts ''
puts ''
puts ''
puts '________________10_______________'
quare_with_coordinates_but_common_alfabet = Ciphrator.square_with_nums_to_common(square_with_lit)
puts 'Read text:'
Ciphrator.read_file('to_cipher')
puts ''
puts 'Ciphered with sqauare alfabet with coordinates liters:'
Ciphrator.alter_ciph('to_cipher', quare_with_coordinates_but_common_alfabet)
puts ''
puts 'Deciphered with sqauare alfabet with coordinates liters:'
Ciphrator.two_i_alter_deciph(quare_with_coordinates_but_common_alfabet, true)
puts '________________________________'
puts ''
puts ''
puts ''
