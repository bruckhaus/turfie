class Dictionary

  def initialize
    @english_words = load_dictionary
  end

  def is_word?(string)
    (@english_words.match /\s#{string}\s/)
  end

  def load_dictionary
    dictionary_file = File.dirname(__FILE__) + '/../db/wordsEn/wordsEn.txt'
    File.readlines(dictionary_file).join(' ')
  end

end
