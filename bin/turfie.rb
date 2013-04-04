#! /usr/bin/env ruby

class Turfie

  require_relative 'cli'
  require_relative 'parser'
  require_relative 'dictionary'
  require_relative 'thesaurus'

  def initialize
    @parser = Parser.new
  end

  def run
    Cli.print_welcome
    loop do
      user_input = Cli.get_input
      break if user_input.empty?
      suggest(user_input)
    end
  end

  def suggest(user_input)
    word_arrays = @parser.get_word_splits(user_input)
    word_arrays.each do |word_array|
      synonym_array = Thesaurus.get_synonyms_array(word_array)
      show_suggestions(synonym_array)
    end
  end

  def show_suggestions(synonym_array, prefix = '')
    puts 'You may like these suggestions:' if prefix == ''
    if synonym_array.length == 1
      puts '... or you may like these suggestions:' if prefix != ''
      synonym_array[0].each do |synonym|
        puts "#{prefix}#{Parser.sanitize(synonym)}"
      end
    else
      synonym_array[0].each do |synonym|
        show_suggestions(synonym_array[1..-1], prefix + Parser.sanitize(synonym))
        puts
      end
    end
  end

end

Turfie.new.run
