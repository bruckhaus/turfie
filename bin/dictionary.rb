class Dictionary

  require_relative 'parser'

  def initialize
    @english_words = load_dictionary
  end

  def is_word?(string)
    clean_string = Parser.sanitize(string)
    (@english_words.match /\s#{clean_string}\s/)
  end

  def load_dictionary
    dictionary_file = File.dirname(__FILE__) + '/../data/wordsEn/wordsEn.txt'
    File.readlines(dictionary_file).join(' ')
  end

end
