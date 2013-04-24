class Sld

  def initialize
    @suggestions = []
  end

  def recommend(words)
    puts 'recommend slds for words:'
    ap words
    synonym_array = Thesaurus.get_synonyms_array(words)
    k             = calculate_index_limit(synonym_array, 1000)
    suggest_for_synonym_array(synonym_array, k)
    ranked_suggestions
  end


  def suggest_for_synonym_array(synonym_array, k = 3, prefix = '')
    if synonym_array.length == 1
      k_shortest(k, synonym_array).each do |synonym|
        @suggestions << "#{prefix}#{Dictionary.sanitize(synonym)}"
      end
    else
      k_shortest(k, synonym_array).each do |synonym|
        suggest_for_synonym_array(synonym_array[1..-1], k, prefix + Dictionary.sanitize(synonym))
      end
    end
  end

  def calculate_index_limit(array, max_size = 1000)
    k = array.max_by { |item| item.length }.length
    loop do
      size = array.inject(1) { |size, item| size * [item.length, k].min }
      break if size <= max_size || k <= 2
      k -= 1
    end
    k
  end

  def ranked_suggestions
    @suggestions.sort_by! { |x| x.length }
  end

  def k_shortest(k, synonym_array)
    synonym_array[0].sort_by { |item| item.length }[0..k-1]
  end

end