require_relative '../app/models/recommender'

describe Recommender do
  it 'recommends domains, TLDs, and SLDs' do
    r = Recommender.new
    r.recommend_slds('goon').should ==
        %w(sap bozo dope thug goon jerk hood moron ninny lummox gorilla bruiser hooligan toughguy strongarm nincompoop)
  end
end