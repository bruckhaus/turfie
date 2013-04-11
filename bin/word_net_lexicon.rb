class WordNetLexicon

  require 'wordnet'
  require 'awesome_print'

  def initialize
    @lexicon               = WordNet::Lexicon.new
    @synset_cache          = {}
    @depth_cache           = {}
    @common_hypernym_cache = {}
  end

  def method_missing(method, *args, &block)
    if @lexicon.respond_to?(method)
      @lexicon.send(method, *args, &block)
    else
      raise NoMethodError
    end
  end

  # Sort array of words by similarity to a set of given anchor words:
  def sort_by_anchors(words, anchors)
    scores = {}
    words.each do |word|
      distances    = word_distances(word, anchors)
      #puts "distances for #{word} / #{anchors}: #{distances}"
      scores[word] = inverse_root_square_score(distances)
    end
    #puts 'scores:'
    #ap scores
    scores.sort_by { |k, v| v }.reverse.collect { |i| i[0] }
  end

  def word_distances(word, anchors)
    distances = []
    anchors.each do |anchor|
      distance = word_distance(word, anchor)
      #puts "distance: #{anchor}/#{word}: #{distance}"
      distances << distance
    end
    distances
  end

  def word_distance(word1, word2)
    return 0 if word1 == word2
    synset1 = synset(word1)
    synset2 = synset(word2)
    #puts "synset1: #{synset1}"
    #puts "synset2: #{synset2}"
    return 999 if synset1.nil? || synset2.nil?
    common_hypernym = common_hypernym(synset1, synset2)
    #puts "common hypernym: #{common_hypernym}"
    distance(common_hypernym, synset1, synset2)
  end

  def common_hypernym(synset1, synset2)
    return nil if synset1.nil? || synset2.nil?
    if @common_hypernym_cache[[synset1, synset2]].nil?
      @common_hypernym_cache[[synset1, synset2]] = synset1 | synset2
    end
    @common_hypernym_cache[[synset1, synset2]]
  end

  def distance(common_hypernym, synset1, synset2)
    depth(synset1) +
        depth(synset2) -
        2 * depth(common_hypernym)
  end

  def synset(word)
    if @synset_cache[word].nil?
      @synset_cache[word] = @lexicon[word]
    end
    @synset_cache[word]
  end

  def depth(synset)
    return 999 if synset.nil?
    if @depth_cache[synset].nil?
      depth  = 1
      parent = synset
      loop do
        parent = parent.hypernyms.first
        break if parent.nil?
        depth += 1
      end
      @depth_cache[synset] = depth
    end
    @depth_cache[synset]
  end

  def inverse_root_square_score(distances)
    distances.map! { |d| (1.0/d)**2 }
    distance_square_sum = distances.inject(0) { |sum, distance| sum + distance }
    Math.sqrt(distance_square_sum)
  end

end
