#! /usr/bin/env ruby

require 'metanym'

puts "Welcome to turfie!\n"

def get_input
  print "\nSearch for domains: "
  user_input = gets.chomp
end

def suggest(user_input)
  query = Metanym.new(user_input)

  suggestions = query.synonyms
end

def show_suggestions(suggestions)
  puts "You may like:\n"
  suggestions.each do |suggestion|
    puts "  #{suggestion}"
  end
end

loop do
  user_input = get_input
  break if user_input.empty?
  suggestions = suggest(user_input)
  show_suggestions(suggestions)
end
