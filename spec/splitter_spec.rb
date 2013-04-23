require_relative '../bin/splitter'

describe Splitter do
  it 'finds all the ways to split a string into valid words' do
    s = Splitter.new
    examples.each { |string, split| s.word_splits(string).should == split }
  end

  def examples
    [
        ['redred', [["redred"], ["red", "red"]]],
        ['bluemangroup', [["bluemangroup"], ["blue", "man", "group"]]],
        ['onetwothreefourfivesixseveneightnineten',
         [["onetwothreefourfivesixseveneightnineten"],
          ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]]],
        ['splitmenot', [['splitmenot']]],
        ['splitthistwice', [["splitthistwice"], ["split", "this", "twice"]]],
        ['kindergarten', [["kindergarten"], ["kin", "der", "gar", "ten"], ["kinder", "gar", "ten"]]],
        # TODO: find more splits here: ["kin", "der", "fore", "man"], ["kinder", "fore", "man"]
        ['kinderforeman', [["kinderforeman"], ["kin", "der", "foreman"], ["kinder", "foreman"]]]
    ]
  end
end