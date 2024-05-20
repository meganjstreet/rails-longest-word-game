require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    vowels = %w[A E I O U]
    @letters = Array.new(4) { vowels.sample }
    @letters += Array.new(6) { (('A'..'Z').to_a - vowels).sample }
    @letters.shuffle!
    @session = session
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters][0...-1]
    url = "https://dictionary.lewagon.com/#{@word}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    valid = word['found']
    @session = session

    if valid
      if @word.chars.all? { |letter| @letters.include?(letter) }
        if @word.chars.all? { |letter| @letters.count(letter) >= @word.count(letter) }
          @results = "Congratulations! #{@word} is a valid English word!"
          @session[:score] += 1
        else
          @results = "Sorry but #{@word} can't be built out of #{@letters.chars.join(',')}"
        end
      else
        @results = "Sorry but #{@word} can't be built out of #{@letters.chars.join(',')}"
      end
    else
      @results = "Sorry but #{@word} does not seem to be a valid English word..."
    end
  end
end
