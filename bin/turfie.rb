#! /usr/bin/env ruby

class Turfie

  require_relative 'cli'
  require_relative 'parser'
  require_relative 'dictionary'
  require_relative 'thesaurus'
  require_relative 'tld'

  def initialize
    @parser      = Parser.new
    @suggestions = []
  end

  def run
    Cli.print_welcome
    loop do
      @suggestions = []
      user_input = Cli.get_input
      break if user_input.empty?
      suggest(user_input)
    end
  end

  def suggest(user_input)
    word_arrays = @parser.get_word_splits(user_input)
    suggest_for_word_arrays(word_arrays)
    rank_suggestions
    show_suggestions
  end

  def show_suggestions
    puts 'You may like these suggestions:'
    @suggestions.each_with_index { |suggestion, rank| puts "  #{rank}. #{suggestion}"}
  end

  def suggest_for_word_arrays(word_arrays)
    word_arrays.each do |word_array|
      synonym_array = Thesaurus.get_synonyms_array(word_array)
      suggest_for_synonym_array(synonym_array)
    end
  end

  def suggest_for_synonym_array(synonym_array, prefix = '')
    if synonym_array.length == 1
      synonym_array[0].each do |synonym|
        @suggestions << "#{prefix}#{Parser.sanitize(synonym)}"
      end
    else
      synonym_array[0].each do |synonym|
        suggest_for_synonym_array(synonym_array[1..-1], prefix + Parser.sanitize(synonym))
      end
    end
  end

  def rank_suggestions
    @suggestions.sort_by! { |x| x.length }
  end

end

#Tld.new.show
#exit
Turfie.new.run
