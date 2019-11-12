require 'open-uri'

class GamesController < ApplicationController
  # VOWELS = %w(A E I O U Y)
  VOWELS = %w[A E I O U Y].freeze

  def new
    # @letters = 10.times.map { ('a'..'z').to_a.sample }
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    # raise
    # Verify if it's in the grid
    # @word = params[:word]
    # Array of characters
    # @word = @word.chars
    # Unique characters
    # @word = @word.uniq
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
