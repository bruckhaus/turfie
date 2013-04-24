class Recommender

  require_relative 'thesaurus'
  require_relative 'splitter'

  def initialize
    @thesaurus   = Thesaurus.new
    @splitter    = Splitter.new
    @suggestions = []
  end

  def recommend(words)
    puts 'recommend for words:'
    ap words
    tlds    = Tld.new.recommend(words)
    slds    = Sld.new.recommend(words)
    domains = %w(Dingdong!) # recommend_domains(slds, tlds)
    return domains, slds, tlds
  end

end