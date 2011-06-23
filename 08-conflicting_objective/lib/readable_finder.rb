#! /usr/bin/ruby

# Dave Thomas' Kata #8: Conflicting Objectives
# http://codekata.pragprog.com/2007/01/kata_eight_conf.html
# 
# Solution by Olivier Melcher <olivier.melcher@gmail.com>
#
# Part 1 : make a program as readable as you can make it.

class ReadableFinder
  def self.find(words)
    matched_words = {}
    
    # Go through the list of words once: O(N)
    # N being the total number of words
    words.each do |first_word|
      
      # For each word, walk the whole list of words again: O(N * N)
      words.each do |last_word|
        concatenated_word = first_word + last_word
        
        # Compare each word to an array using a linear search, worst case: O(N * N * N)
        if concatenated_word.size == 6 and words.include?(concatenated_word)
          matched_words[concatenated_word] = [first_word, last_word]
        end
      end
    end
    
    matched_words
  end
  
  def self.print(matched_words)
    matched_words.each do |concatenated_word, parts|
      puts "#{parts[0]} + #{parts[1]} => #{concatenated_word}"
    end
  end
end