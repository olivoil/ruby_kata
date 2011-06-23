require 'rspec'
Dir[File.join('./lib', '*.rb')].each {|f| require f}

describe AnagramFinder do
  let(:words) { %w(globe enlist silent players with blog listen wits parsley replays sparely actaeonidae donatiaceae abcdefghiklmnopqrstuvwxyz) }
  let(:finder) { AnagramFinder.new(words) }
  
  describe "#find" do
    it "finds anagrams for a word" do
      finder.find('inlets').should == %w(enlist silent listen)
      finder.find('players').should == %w(players parsley replays sparely)
    end
  end
  
  describe "#anagrams" do
    it "finds all anagrams in the dictionary" do
      finder.anagrams.values.should include %w(enlist silent listen)
      finder.anagrams.values.should include %w(players parsley replays sparely)
      finder.anagrams.values.should include %w(actaeonidae donatiaceae)
      finder.anagrams.length.should == 3
    end
  end
  
  describe "#longest_words" do
    it "finds the longest anagrammed words" do
      finder.longest_words.should == %w(actaeonidae donatiaceae)
    end
  end
  
  describe "#longest_anagram" do
    it "finds the anagram with the most words" do
      finder.longest_anagram.should == %w(players parsley replays sparely)
    end
  end
  
end

