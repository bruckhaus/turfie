#! /usr/bin/env ruby

class Turfie

  require 'metanym'

  def initialize
    @english_words = load_dictionary
  end

  def get_input
    print "\nSearch for domains: "
    gets.chomp
  end

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

  def sanitize(string)
    string.gsub(/[- '-*]/, '')
  end

  def show_suggestions(synonym_array, prefix = '')
    puts 'You may like these suggestions:' if prefix == ''
    if synonym_array.length == 1
      puts '... or you may like these suggestions:' if prefix != ''
      synonym_array[0].each do |synonym|
        puts "#{prefix}#{sanitize(synonym)}"
      end
    else
      synonym_array[0].each do |synonym|
        show_suggestions(synonym_array[1..-1], prefix + sanitize(synonym))
        puts
      end
    end
  end

  def load_dictionary
    dictionary_file = File.dirname(__FILE__) + '/../db/wordsEn/wordsEn.txt'
    File.readlines(dictionary_file).join(' ')
  end

  def print_welcome
    puts "Welcome to turfie!\n"
  end

  def get_word_splits(string)
    words = [[string]]
    last  = string.length - 1
    (0..(last-1)).each do |pos|
      word_1 = string[0..pos]
      word_2 = string[(pos + 1)..-1]
      if is_word?(word_1) && is_word?(word_2)
        words << [word_1, word_2]
      end
    end
    puts "found these words in your input: #{words}\n"
    words
  end

  def is_word?(string)
    (@english_words.match /\s#{string}\s/)
  end

  def run
    print_welcome

    loop do
      user_input = get_input
      break if user_input.empty?

      word_arrays = get_word_splits(user_input)
      word_arrays.each do |word_array|
        synonym_array = get_synonyms_array(word_array)
        show_suggestions(synonym_array)
      end

    end
  end

end

Turfie.new.run
