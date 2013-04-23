class Dictionary

  def self.sanitize(string)
    string.scan(/[[:alnum:]]/).join
  end

  def initialize
    @english_words = load_dictionary
  end

  def is_word?(string)
    clean_string = Dictionary.sanitize(string)
    (@english_words.match /\s#{clean_string}\s/)
  end

  def load_dictionary
    File.readlines(dictionary_file).join(' ')
  end

  def dictionary_file
    File.dirname(__FILE__) + '/../data/wordsEn/wordsEn.txt'
  end

end