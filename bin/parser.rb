class Parser

  require_relative 'dictionary'

  def initialize
    @dictionary = Dictionary.new
  end

  def get_word_splits(string)
    results = [[string]]
    split   = find_split(string)
    results << split unless split == []
    puts "found these words in your input: #{results}\n"
    results
  end

  def find_split(string)
    split = []
    last  = string.length - 1

    (2..(last-3)).each do |pos|

      part_1 = string[0..pos]
      part_2 = string[(pos + 1)..-1]

      is_word_1 = @dictionary.is_word?(part_1)
      is_word_2 = @dictionary.is_word?(part_2)

      if is_word_1 && is_word_2
        split << [part_1, part_2]
      elsif is_word_1
        split_2 = find_split(part_2)
        if valid_split(split_2)
          split << [part_1, split_2]
          break
        end
      end

    end
    split.flatten
  end

  def valid_split(split)
    split != []
  end

  def self.sanitize(string)
    string.scan(/[[:alnum:]]/).join
  end

end
