# frozen_string_literal: true

require 'colorize'

require_relative 'board'
require_relative 'code_maker'
require_relative 'code_breaker'

class Mastermind
  attr_accessor :board, :code_maker, :code_breaker
  
  def initialize
    @board = Board.new
    @code_maker = CodeMaker.new
    @code_breaker = CodeBreaker.new
  end

  def play
    game_start
    
    loop do
      guess = @code_breaker.guess
      hints = @code_maker.give_hints(guess)
      @board.update(guess, hints)
      @board.print
      
      break if game_over?(guess)
    end
  end

  private

  def game_start
    print "\n\n"
    print "\t\t"
    print "*".colorize(color: :red, mode: :bold)
    print "*".colorize(color: :blue, mode: :bold)
    print "*".colorize(color: :green, mode: :bold)
    print "  MASTERMIND  "
    print "*".colorize(color: :cyan, mode: :bold)
    print "*".colorize(color: :magenta, mode: :bold)
    print "*".colorize(color: :yellow, mode: :bold)
    print "\n\n"

    @board.print
  end

  def game_over?(guess)
    @code_maker.code_broken?(guess) || @board.full?
  end
end