require "open-uri"

class GamesController < ApplicationController
  def home

  end

  def new
    @letters = Array.new(10) { ("a".."z").to_a.sample}
    # @letters = @letters.each do |letter|
    #   @letter = letter
    # end
  end

  def score
    raise
    @letters = params[:letters].split
    @the_words = params[:word]
    if included?(@the_words, @letters)
      if english_word?(@the_words)
        @score = "Congratulations #{@the_words}"
      else
        @score = "Sorry but #{@the_words} is not en english word"
      end
    else
      @score = "the word contains letters that are not in the grid"
    end
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

end
