class Cli

  require_relative 'parser'

  class << self

    def print_welcome
      puts "Welcome to turfie!\n"
    end

    def get_input
      print "\nSearch for domains: "
      Parser.sanitize(gets.chomp)
    end

  end
end
