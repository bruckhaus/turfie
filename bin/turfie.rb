#! /usr/bin/env ruby

class Turfie

  require 'awesome_print'
  require_relative 'cli'
  require_relative 'dictionary'
  require_relative 'splitter'
  require_relative 'thesaurus'
  require_relative 'tld'

  def initialize
    @splitter = Splitter.new
    @suggestions = []
  end

  def run
    Cli.print_welcome
    loop do
      @suggestions = []
      user_input   = Cli.get_input
      break if user_input.empty?
      suggest(user_input)
    end
  end

  def suggest(user_input)
    word_arrays = @splitter.word_splits(user_input)
    suggest_for_word_arrays(word_arrays)
    rank_suggestions
    show_suggestions
  end

  def show_suggestions
    puts 'You may like these suggestions:'
    @suggestions[0..29].each_with_index { |suggestion, rank| puts "  #{rank}. #{suggestion}" }
  end

  def suggest_for_word_arrays(word_arrays)
    word_arrays.each do |word_array|
      synonym_array = Thesaurus.get_synonyms_array(word_array)
      k = calculate_index_limit(synonym_array, 1000)
      suggest_for_synonym_array(synonym_array, k)
    end
  end

  def suggest_for_synonym_array(synonym_array, k = 3, prefix = '')
    if synonym_array.length == 1
      k_shortest(k, synonym_array).each do |synonym|
        @suggestions << "#{prefix}#{Dictionary.sanitize(synonym)}"
      end
    else
      k_shortest(k, synonym_array).each do |synonym|
        suggest_for_synonym_array(synonym_array[1..-1], k, prefix + Dictionary.sanitize(synonym))
      end
    end
  end

  def k_shortest(k, synonym_array)
    synonym_array[0].sort_by { |item| item.length }[0..k-1]
  end

  def rank_suggestions
    @suggestions.sort_by! { |x| x.length }
  end

  def calculate_index_limit(array, max_size = 1000)
    k = array.max_by { |item| item.length }.length
    loop do
      size = array.inject(1) { |size, item| size * [item.length, k].min }
      break if size <= max_size || k <= 2
      k -= 1
    end
    k
  end

end

Turfie.new.run
