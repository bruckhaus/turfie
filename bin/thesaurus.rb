class Thesaurus

  require 'metanym'

  class << self

    def get_synonyms(word)
      (Metanym.new(word).synonyms << word).uniq
    end

    def get_synonyms_array(word_array)
      synonyms_array = []
      word_array.each do |word|
        synonyms = get_synonyms(word)
        puts "Similar words for \"#{word}\": #{synonyms}"
        synonyms_array << synonyms
      end
      synonyms_array
    end

  end
end