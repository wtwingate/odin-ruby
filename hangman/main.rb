# frozen_string_literal: true

require_relative 'lib/ascii_art'
require_relative 'lib/hangman'

def main
  saved_games = Dir.children('saved_games') if Dir.exist?('saved_games')

  if saved_games
    title_screen

    puts 'Load a saved game? (Y/n)'

    input = gets.chomp.upcase

    input == 'Y' ? select_save_file(saved_games) : start_new_game
  else
    start_new_game
  end
end

def title_screen
  system('clear')

  puts AsciiArt::HANGMAN.last

  puts 'HANGMAN'.center(26)
  puts
end

def select_save_file(saved_games)
  title_screen

  saved_games.each_with_index do |file, index|
    puts "#{index + 1}) #{file}"
  end

  puts 'Enter a number to choose a save:'

  loop do
    input = gets.chomp.to_i - 1

    next unless input >= 0 && saved_games[input]

    load_saved_game(saved_games[input])
  end
end

def start_new_game
  game = Hangman.new
  game.play
end

# rubocop: disable Security/MarshalLoad
def load_saved_game(file_name)
  file_path = File.join('saved_games', file_name)
  game = Marshal.load(File.read(file_path))
  game.play
end
# rubocop: enable Security/MarshalLoad

main if __FILE__ == $PROGRAM_NAME
