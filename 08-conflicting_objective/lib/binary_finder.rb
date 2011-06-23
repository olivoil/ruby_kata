#! /usr/bin/ruby

# Dave Thomas' Kata #8: Conflicting Objectives
# http://codekata.pragprog.com/2007/01/kata_eight_conf.html
# 
# Solution by Olivier Melcher <olivier.melcher@gmail.com>
# 
# Part 2 : optimize the program to run as fast as you can make it.


class BinaryFinder
  class << self

    def find(words)
      matched_words = {}

      words_by_length = classify_by_length(words)
      
      words_by_length[6].each do |six_letter_word|
        5.times do |n|
          first_word  = six_letter_word[0..n]
          second_word = six_letter_word[n+1..5]
          
          if words_by_length[n+1].include?(first_word) && words_by_length[5-n].include?(second_word)
            matched_words[six_letter_word] = [ first_word, second_word ]
          end
        end
      end
    
      matched_words
    end
  
    def classify_by_length(words) 
      default_hash = Hash.new { |hash, key| hash[key] = BinaryArray.new}
      words.inject(default_hash) do |result, word| 
        length = word.length
        result[length] << word if length <= 6
        result 
      end
    end
  
    def print(matched_words)
      matched_words.each do |concatenated_word, parts|
        puts "#{parts[0]} + #{parts[1]} => #{concatenated_word}"
      end
    end
    
  end
end


# For a full implementation of this algorithm, see https://github.com/tyler/binary_search by Tyler McMullen
class BinaryArray < Array
  def initialize
    @sorted = false
    super
  end
  
  def include?(target)
    !!index(target)
  end

  def index(target)
    unless @sorted
      sort!
      @sorted = true
    end
  
    upper_limit = self.size - 1
    lower_limit = 0

    while(upper_limit >= lower_limit) do
      index = lower_limit + (upper_limit - lower_limit) / 2
      test  = target <=> self[index]
 
      if test == 0
        return index
      elsif test > 0
        lower_limit = index + 1
      else
        upper_limit = index - 1
      end
    end
    
    nil
  end
end