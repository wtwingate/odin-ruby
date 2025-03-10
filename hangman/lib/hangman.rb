# frozen_string_literal: true

require 'colorize'
require 'fileutils'

# This class implements the Hangman game.
class Hangman
  MAX_WRONG = 7

  def initialize
    @secret_word = random_word
    @guesses = []
    @wrong = 0
  end

  def play
    until over?
      render
      @guesses << player_input
      @wrong += 1 unless @secret_word.include?(@guesses.last)
    end

    end_screen
  end

  private

  def random_word
    words = File.readlines('words.txt').map do |line|
      line.strip.upcase
    end

    words.filter { |word| word.length >= 5 }.sample
  end

  def player_input
    print 'Enter your next guess: '

    loop do
      input = gets.chomp.upcase

      quit if input == 'QUIT'
      save_and_quit if input == 'SAVE'

      return input if valid?(input)

      print 'Invalid input. Please try again: '
    end
  end

  def quit
    system('clear')
    exit
  end

  def save_and_quit
    FileUtils.mkdir_p('saved_games')
    file_name = Time.now.iso8601
    File.write("saved_games/#{file_name}", Marshal.dump(self))

    quit
  end

  def valid?(input)
    input.length == 1 &&
      input.match?(/[A-Z]/) &&
      !@guesses.include?(input)
  end

  def over?
    won? || @wrong == MAX_WRONG
  end

  def won?
    @secret_word.chars.all? do |char|
      @guesses.include?(char)
    end
  end

  def render
    system('clear')

    puts AsciiArt::HANGMAN[@wrong]

    puts format_secret_word
    puts

    puts format_alphabet('A'..'M')
    puts format_alphabet('N'..'Z')
    puts
  end

  def format_secret_word
    @secret_word.chars.map do |letter|
      @guesses.include?(letter) ? letter : '_'
    end.join(' ').center(26)
  end

  def format_alphabet(letters)
    letters.map do |letter|
      if @guesses.include?(letter)
        letter.colorize(color: :default, mode: :dim)
      else
        letter.colorize(color: :default, mode: :bold)
      end
    end.join(' ')
  end

  def end_screen
    render

    puts 'The secret word was'.center(26)
    puts @secret_word.center(26)
    puts

    if won?
      puts 'Ya did it, kid!'.center(26)
    else
      puts 'Rest in Peace'.center(26)
    end
  end
end
