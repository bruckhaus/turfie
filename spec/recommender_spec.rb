require_relative '../app/models/recommender'

describe Recommender do
  it 'recommends domains, TLDs, and SLDs' do
    r = Recommender.new
    r.recommend(%w(goon)).should ==
        [%w(Dingdong!),
         %w(sap bozo dope thug goon jerk hood moron ninny lummox gorilla
            bruiser hooligan toughguy strongarm nincompoop),
         %w(world observer expert gay engineer active democrat architect
            progressive guardian host esq ismaili guru accountant actor
            attorney author adult catholic vip lawyer broker life scot total vet dog mormon viking cpa)]
  end
end