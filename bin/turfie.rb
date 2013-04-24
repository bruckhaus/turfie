#! /usr/bin/env ruby

class Turfie

  require 'awesome_print'
  require_relative '../app/models/cli'
  require_relative '../app/models/splitter'
  require_relative '../app/models/tld'
  require_relative '../app/models/sld'
  require_relative '../app/models/recommender'

  def initialize
    @splitter    = Splitter.new
    @suggestions = []
    @recommender = Recommender.new
  end

  def run
    Cli.print_welcome
    loop do
      @suggestions = []
      user_input   = Cli.get_input
      break if user_input.empty?
      splits = @splitter.word_splits(user_input)
      puts 'splits:'
      ap splits
      splits.each do |words|
        domains, slds, tlds = @recommender.recommend(words)
        Cli.show('domains', domains)
        Cli.show('TLDs', tlds)
        Cli.show('second-level domains', slds)
      end
    end
  end
end

Turfie.new.run