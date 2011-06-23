class AnagramFinder
  attr_reader :anagrams
  
  def initialize(word_list)
    @dictionary  = word_list
    @anagrams    = Hash.new { |hash, key| hash[key] = [] }
    @longest     = ''
    
    find_anagrams!
  end
  
  def find_anagrams!
    @dictionary.each do |word|
      index = sort_to_sym(word)
      @anagrams[sort_to_sym(word)] << word
      @longest = sort_to_sym(word) if @longest.length < word.length && @anagrams[index].length > 1
    end
    
    @anagrams.reject!{ |index, words| words.length <= 1}
  end
  
  def sort_to_sym(word)
    word.split(//).sort.join.to_sym
  end
  
  def find(term = nil)
    @anagrams[sort_to_sym(term)]
  end
  
  def longest_words
    @anagrams[@longest] unless @longest.empty?
  end
  
  def longest_anagram
    @anagrams.max_by{ |index, words| words.length }.last
  end
end


# Anagram.new(word_list).find #=> All anagrams
# Anagram.new(word_list).find('word') #=> array of words