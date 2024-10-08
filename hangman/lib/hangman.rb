# frozen_string_literal: true

class Hangman
  attr_accessor :secret_word, :guesses_remaining, :previous_guesses

  def initialize
    @secret_word = select_secret_word
    @guesses_remaining = 7
    @previous_guesses = []
  end

  def play_game
    print_board

    loop do
      guess_letter
      print_board
      break if game_over?
    end

    if @guesses_remaining.zero?
      puts 'Boo! You lost!'
      puts "The secret word was #{@secret_word}"
    else
      puts 'Congrats! You won!'
    end
  end

  def to_s
    "#{@secret_word} #{@guesses_remaining} #{@previous_guesses}"
  end

  private

  def guess_letter
    loop do
      print 'Guess a letter: '
      input = gets.chomp.upcase

      execute_command(input)

      if input == 'LOAD'
        print_board
        next
      end

      if @previous_guesses.include? input[0]
        puts 'You already guessed that letter, ya dingus!'
        next
      end

      @guesses_remaining -= 1 unless @secret_word.include? input[0]
      @previous_guesses.push(input[0])
      break
    end
  end

  def execute_command(input)
    case input
    when 'QUIT'
      exit(0)
    when 'SAVE'
      save_game
      exit(0)
    when 'LOAD'
      load_game
    end
  end

  def save_game
    Dir.mkdir 'saved_games' unless Dir.exist? 'saved_games'
    filename = "saved_games/#{Time.now}"
    game_data = Marshal.dump(self)

    File.open(filename, 'w') do |file|
      file.write(game_data)
    end
  end

  def load_game
    saved_games = Dir.entries('saved_games').select do |f|
      File.file? File.join('saved_games', f)
    end

    return if saved_games.empty?

    saved_games.each_with_index do |filename, index|
      puts "#{index}:\t#{filename}"
    end

    loop do
      print "Enter save number or 'q' to quit: "
      input = gets.chomp

      return if input == 'q'

      begin
        filename = saved_games[input.to_i]
        File.open("saved_games/#{filename}", 'r') do |file|
          data = Marshal.load(file)
          self.secret_word = data.secret_word
          self.previous_guesses = data.previous_guesses
          self.guesses_remaining = data.guesses_remaining
        end
        break
      rescue StandardError
        next
      end
    end
  end

  def print_board
    @secret_word.chars.each do |letter|
      if @previous_guesses.include? letter
        print " #{letter}"
      else
        print ' _'
      end
    end
    print "\n"
    puts "Guesses remaining: #{@guesses_remaining}"
  end

  def game_over?
    @guesses_remaining.zero? || full_match?
  end

  def full_match?
    full_match = true
    @secret_word.chars.each do |letter|
      full_match = false unless @previous_guesses.include? letter
    end

    full_match
  end

  def select_secret_word
    dictionary = File.read('dictionary.txt')
    words = dictionary.split.select do |word|
      word.size >= 5 && word.size <= 12
    end
    words.sample.upcase
  end
end
