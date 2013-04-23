#! /usr/bin/env ruby

class Tld

  require 'csv'
  require_relative 'word_net_lexicon'

  include Enumerable

  def initialize
    @lexicon = WordNetLexicon.new
    @tlds    = load
  end

  def suggest(words)
    words = [words].flatten
    @lexicon.sort_by_anchors(@tlds, words)[0..30]
  end

  def show
    puts "TLDs: #{@tlds}"
  end

  # remove first item from header row, make unique, sort, downcase, etc.
  def sanitize(tlds)
    tlds = tlds[1..-1]
    tlds.uniq!.sort!
    tlds.map! { |tld| tld.downcase }
    tlds.reject { |tld| @lexicon[tld].nil? }
  end

  def load
    tlds = []
    CSV.foreach(tld_file, :quote_char => '"', :col_sep => ',', :row_sep => :auto) do |row|
      tld = row[0]
      tlds << tld
    end
    sanitize(tlds)
    #%w(apple mango fruit)
  end

  def each
    @tlds.each { |tld| yield tld }
  end

  def tld_file
    File.dirname(__FILE__) + '/../data/tld/strings-1200utc-13jun12-en.csv'
  end

end
