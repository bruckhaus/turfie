class Tld

  require 'csv'

  def initialize
    @tlds = load
  end

  def show
    puts "TLDs: #{@tlds}"
  end

  def load
    tlds = []
    CSV.foreach(tld_file, :quote_char => '"', :col_sep => ',', :row_sep => :auto) do |row|
      tld = row[0]
      tlds << tld
    end
    sanitize(tlds)
  end

  # remove field from header row, make unique, sort, and downcase
  def sanitize(tlds)
    tlds = tlds[1..-1]
    tlds.uniq!.sort!
    tlds.map { |tld| tld.downcase }
  end

  def tld_file
    File.dirname(__FILE__) + '/../data/tld/strings-1200utc-13jun12-en.csv'
  end

end
