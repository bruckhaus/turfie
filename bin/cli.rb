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

  end
end
