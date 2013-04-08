class WordNetLexicon

  require 'wordnet'
  require 'awesome_print'

  def initialize
    @lexicon = WordNet::Lexicon.new
  end

  # Sort array of words by similarity to a set of given anchor words:
  def sort_by_anchors(words, anchors)
    scores = {}
    words.each do |word|
      distances    = word_distances(word, anchors)
      scores[word] = inverse_root_square_score(distances)
    end
    puts 'scores:'
    ap scores
    scores.sort_by { |k, v| v }.reverse.collect { |i| i[0] }
  end

  def word_distances(word, anchors)
    distances = []
    anchors.each do |anchor|
      distance = word_distance(word, anchor)
      puts "distance: #{anchor}/#{word}: #{distance}"
      distances << distance
    end
    distances
  end

  def word_distance(word1, word2)
    synset1 = @lexicon[word1]
    synset2 = @lexicon[word2]
    #puts "synset1: #{synset1}"
    #puts "synset2: #{synset2}"

    return 999 if synset1.nil? || synset2.nil?

    common_hypernym = synset1 | synset2
    #puts "common hypernym: #{common_hypernym}"

    distance = (depth(synset1) + depth(synset2)) / 2.0 * depth(common_hypernym)
    #puts "distance: #{distance}"
    distance
  end

  def depth(synset)
    #puts "depth: #{synset}"
    return 999 if synset.nil?
    depth = 1
    loop do
      synset = synset.hypernyms.first
      #puts "hypernym: #{synset}"
      return depth if synset.nil?
      depth += 1
    end
  end

  def inverse_root_square_score(distances)
    distances.map! { |d| (1.0/d)**2 }
    distance_square_sum = distances.inject(0) { |sum, distance| sum + distance }
    Math.sqrt(distance_square_sum)
  end

end
