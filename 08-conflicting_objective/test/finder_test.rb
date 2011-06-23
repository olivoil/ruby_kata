$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'test/unit'
require 'readable_finder'
require 'fast_finder'
require 'binary_finder'

class FinderTest < Test::Unit::TestCase
  
  def test_should_return_matches_for_a_simple_list_of_words
    words = ['al', 'bums', 'albums', 'bar', 'ely', 'barely']
    
    [ReadableFinder, FastFinder, BinaryFinder].each do |finder|
      found_words = finder.find words
      assert_equal 2, found_words.size
    end
  end
  
  def test_should_not_return_matches
    words = ['al', 'bums', 'barely']    
    
    [ReadableFinder, FastFinder, BinaryFinder].each do |finder|
      found_words = finder.find words
      assert_equal 0, found_words.size, "should not have returned results, but returned #{found_words.size} : #{found_words.inspect}"
    end
  end
  
  def test_fast_finder_classify_by_length
    words = ['al', 'bums', 'albums', 'bar', 'ely', 'barely']
    words_by_length = FastFinder.classify_by_length words
    
    assert words_by_length[1].to_a == []
    assert words_by_length[2].to_a == ['al']
    assert words_by_length[3].to_a == ['bar', 'ely']
    assert words_by_length[4].to_a == ['bums']
    assert words_by_length[5].to_a == []
    assert words_by_length[6].to_a == ['albums', 'barely']
  end
  
end