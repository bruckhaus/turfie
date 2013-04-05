class Tld

  require 'csv'

  def initialize
    @tlds = load
  end

  def load
    tld_file = File.dirname(__FILE__) + '/../data/tld/strings-1200utc-13jun12-en.csv'
    puts "\n"
    CSV.foreach(tld_file, :quote_char => '"', :col_sep =>',', :row_sep =>:auto) do |row|
      print "#{row[0]}, "
    end
  end

end
