class Board
  def initialize(secret)
    @size = 12
    @guesses = Array.new(@size)
    @hints = Array.new(@size)
    @secret = secret
    @next = 0
  end

  def update(guess)
    @guesses[@next] = guess
    hint = generate_hint(guess)
    @hints[@next] = hint
    @next += 1
  end

  def render
    formatted_rows = []
    @size.times do |index|
      formatted_rows << format_row(index)
    end

    puts formatted_rows.reverse
  end

  private

  def generate_hint(guess)
    full_matches = count_full_matches(guess)
    half_matches = count_half_matches(guess) - full_matches

    hint = []
    full_matches.times { hint << :full }
    half_matches.times { hint << :half }

    hint
  end

  def count_full_matches(guess)
    full_matches = 0
    guess.each_with_index do |color, index|
      full_matches += 1 if @secret[index] == color
    end

    full_matches
  end

  def count_half_matches(guess)
    half_matches = 0
    guess.each do |color|
      half_matches += 1 if @secret.include? color
    end

    half_matches
  end

  def format_row(index)
    guess = format_guess(@guesses[index])
    hint = format_hint(@hints[index])
    "#{guess} #{hint}"
  end

  def format_guess(guess)
    return '|   |   |   |   |' if guess.nil?

    formatted = '|'
    guess.each { |item| formatted << " #{Colors::DISPLAY[item]} |" }
    formatted
  end

  def format_hint(hint)
    return '' if hint.nil?

    formatted = ''
    hint.each { |item| formatted << Colors::DISPLAY[item] }
    formatted
  end
end
