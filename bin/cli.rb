class Cli

  class << self

    def print_welcome
      puts "Welcome to turfie!\n"
    end

    def get_input
      print "\nSearch for domains: "
      gets.chomp
    end

  end
end
