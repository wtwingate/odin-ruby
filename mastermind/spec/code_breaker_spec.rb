# frozen_string_literal: true

require './lib/code_breaker'

describe CodeBreaker do
  let(:code_breaker) { described_class.new }

  describe '#clean_input' do
    it 'converts string to array of characters' do
      input = 'RGBY'
      expect(code_breaker.send(:clean_input, input)).to eq(%w[R G B Y])
    end

    it 'removes excess whitespace from input' do
      input = '    r   g  b     y   '
      expect(code_breaker.send(:clean_input, input)).to eq(%w[R G B Y])
    end

    it 'converts input characters to uppercase' do
      input = 'rgby'
      expect(code_breaker.send(:clean_input, input)).to eq(%w[R G B Y])
    end
  end

  describe '#valid_guess?' do
    it 'returns true when guess has valid length and characters' do
      guess = %w[R G B Y]
      expect(code_breaker.send(:valid_guess?, guess)).to be true
    end

    it 'returns false when guess contains invalid characters' do
      guess = %w[R G B Z]
      expect(code_breaker.send(:valid_guess?, guess)).to be false
    end

    it 'returns false when guess is too short' do
      guess = %w[R G B]
      expect(code_breaker.send(:valid_guess?, guess)).to be false
    end

    it 'returns false when guess is too long' do
      guess = %w[R G B R G B]
      expect(code_breaker.send(:valid_guess?, guess)).to be false
    end
  end
end
