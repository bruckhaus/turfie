class Parser

  require_relative 'dictionary'

  def initialize
    @dictionary = Dictionary.new
  end

  def get_word_splits(string)
    words = [[string]]
    last  = string.length - 1
    (0..(last-1)).each do |pos|
      word_1 = string[0..pos]
      word_2 = string[(pos + 1)..-1]
      if @dictionary.is_word?(word_1) && @dictionary.is_word?(word_2)
        words << [word_1, word_2]
      end
    end
    puts "found these words in your input: #{words}\n"
    words
  end

  def self.sanitize(string)
    string.scan(/[[:alnum:]]/).join
  end

end
