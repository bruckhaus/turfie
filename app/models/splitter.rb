class Splitter

  require_relative 'dictionary'

  def initialize
    @dictionary = Dictionary.new
  end

  # Return string and any splits of string that consist of valid words.
  def word_splits(string, is_sub_string = false)
    if is_sub_string
      splits = nil
    else
      splits = [[string]]
    end
    search_range(string, 3).each do |pos|

      part_1 = string[0..pos]
      part_2 = string[(pos + 1)..-1]

      is_word_1 = @dictionary.is_word?(part_1)
      is_word_2 = @dictionary.is_word?(part_2)

      if is_word_1 && is_word_2
        if is_sub_string
          return [part_1, part_2]
        else
          splits << [part_1, part_2]
        end
      elsif is_word_1
        split_2 = word_splits(part_2, true)
        unless split_2.nil?
          if is_sub_string
            return [part_1, split_2].flatten
          else
            splits << [part_1, split_2].flatten
          end
        end
      end

    end
    splits
  end

  # Return range of valid split positions p for string s so that s == s[0..p] + s[p+1..-1].
  # Ensure that length of s[0..p].length >= min_length, and s[p+1..-1].length >= min_length.
  def search_range(string, min_length = 3)
    ((min_length - 1)..(string.length - 1 - min_length))
  end

end