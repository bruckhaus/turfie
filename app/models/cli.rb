class Cli

  require_relative 'dictionary'

  class << self

    def print_welcome
      puts "Welcome to turfie!\n"
    end

    def get_input
      print "\nSearch for domains: "
      Dictionary.sanitize(gets.chomp)
    end

    def show(label, items, count = 30)
      puts "You may like these suggested #{label}:"
      items[0..(count-1)].each_with_index { |item, rank| puts "  #{rank}. #{item}" }
    end

  end
end
