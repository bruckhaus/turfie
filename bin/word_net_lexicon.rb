class WordNetLexicon

  require 'wordnet'

  def initialize
    @lexicon = WordNet::Lexicon.new
  end

  def word_distance(word1, word2)
    synset1 = @lexicon.lookup_synsets(word1)
    synset2 = @lexicon.lookup_synsets(word2)

    puts "synset1: #{synset1}"
    puts "synset2: #{synset2}"

    common_hypernym = synset1 | synset2
    (depth(synset1) + depth(synset2)) / 2.0 * depth(common_hypernym)
  end

  def depth(synset)
    depth = 0
    loop do
      print "#{depth}, "
      synset = synset.hypernyms
      depth += 1
    end
    depth
  end

  # Sort array of words by similarity to a set of given anchor words:
  def sort_by_anchors(words, anchors)
    scores = {}
    words.each do |word|
      distances    = word_distances(word, anchors)
      scores[word] = inverse_root_square_score(distances)
    end
    scores.sort_by! { |k, v| v }.reverse
    scores.collect! { |k, v| k }
  end

  def word_distances(word, anchors)
    distances = []
    anchors.each do |anchor|
      distances << word_distance(word, anchor)
    end
    distances
  end

  def inverse_root_square_score(distances)
    distances.map { |d| (1.0/d)^2 }
    distance_square_sum = distances.inject(0) { |sum, distance| sum + distance }
    Math.sqrt(distance_square_sum)
  end

end
