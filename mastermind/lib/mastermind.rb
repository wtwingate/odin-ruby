# frozen_string_literal: true

# This class introduces Mastermind and allows the user to select a game mode.
class Mastermind
  def start
    puts start_message

    case select_mode
    when 1
      game = CodeBreaker.new
      game.play
    when 2
      game = CodeMaker.new
      game.play
    end
  end

  private

  def select_mode
    loop do
      puts select_mode_message
      mode = gets.chomp.downcase

      case mode
      when '1', '2' then return mode.to_i
      when 'q' then exit
      end
    end
  end

  def start_message
    <<~MESSAGE

      *** Welcome to Mastermind ***

      Mastermind is a game of making and breaking secret codes. One player,
      the Code Maker, creates a secret code out of six possible colors. The
      other player, the Code Breaker, is tasked with deducing the secret code
      within 12 guesses. After each guess, the Code Maker will give a hint to
      let the Code Breaker know how close their previous guess was.

    MESSAGE
  end

  def select_mode_message
    <<~MESSAGE
      Please select your role:
      Enter '1' to be the Code Breaker.
      Enter '2' to be the Code Maker.
      Or, enter 'q' to quit.
    MESSAGE
  end
end
