#! /usr/bin/ruby

# Dave Thomas' Kata #8: Conflicting Objectives
# http://codekata.pragprog.com/2007/01/kata_eight_conf.html
# 
# Solution by Olivier Melcher <olivier.melcher@gmail.com>
# 
# Part 2 : optimize the program to run as fast as you can make it.

require 'set'

class FastFinder
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
      default_hash = Hash.new { |hash, key| hash[key] = Set.new}
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