require './lib/code_maker'

describe CodeMaker do
  let(:code_maker) { CodeMaker.new }

  describe '#code_broken?' do
    it 'returns false if guess is wrong' do
      code_maker.instance_variable_set(:@secret_code, %w[R R R R])
      expect(code_maker.code_broken?(%w[B B B B])).to be false
    end

    it 'returns true if guess is correct' do
      code_maker.instance_variable_set(:@secret_code, %w[R R R R])
      expect(code_maker.code_broken?(%w[R R R R])).to be true
    end
  end

  describe '#give_hints' do
    it 'returns no hints if all guesses are wrong' do
      code_maker.instance_variable_set(:@secret_code, %w[R R R R])
      guesses = %w[B B B B]
      expect(code_maker.give_hints(guesses)).to eq({ full: 0, half: 0 })
    end

    it 'identifies four full matches if all guesses have correct color and position' do
      code_maker.instance_variable_set(:@secret_code, %w[R R R R])
      guesses = %w[R R R R]
      expect(code_maker.give_hints(guesses)).to eq({ full: 4, half: 0 })
    end

    it 'identifies four half matches if all guesses have correct color but wrong position' do
      code_maker.instance_variable_set(:@secret_code, %w[R G B C])
      guesses = %w[C B G R]
      expect(code_maker.give_hints(guesses)).to eq({ full: 0, half: 4 })
    end

    it 'identifies only one full match if same color is guessed repeatedly' do
      code_maker.instance_variable_set(:@secret_code, %w[R G B C])
      guesses = %w[R R R R]
      expect(code_maker.give_hints(guesses)).to eq({ full: 1, half: 0 })
    end

    it 'identifies only one half match if same color is guessed repeatedly' do
      code_maker.instance_variable_set(:@secret_code, %w[R G G G])
      guesses = %w[B R R R]
      expect(code_maker.give_hints(guesses)).to eq({ full: 0, half: 1 })
    end

    it 'identifies combinations of full and half matches' do
      code_maker.instance_variable_set(:@secret_code, %w[R G B R])
      guesses = %w[R B G R]
      expect(code_maker.give_hints(guesses)).to eq({ full: 2, half: 2 })
    end
  end
end
