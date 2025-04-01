# frozen_string_literal: true

require_relative '../lib/board'

# rubocop: disable Metrics
describe Board do
  describe '#full?' do
    subject(:board) { described_class.new }
    let(:token) { :foo }

    context 'when the grid is full' do
      before do
        grid = Array.new(7) { Array.new(6) { token } }
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_full
      end
    end

    context 'when the grid is empty' do
      before do
        grid = Array.new(7) { Array.new(6) }
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns false' do
        expect(board).not_to be_full
      end
    end

    context 'when the grid is almost full' do
      before do
        grid = Array.new(7) { Array.new(6) { token } }
        grid[0][0] = nil
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns false' do
        expect(board).not_to be_full
      end
    end

    context 'when the grid is almost empty' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[0][0] = token
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns false' do
        expect(board).not_to be_full
      end
    end
  end

  describe '#column_full?' do
    subject(:board) { described_class.new }
    let(:token) { :foo }
    let(:index) { 0 }

    context 'when the specified column is full' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[index] = Array.new(6) { token }
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board.column_full?(index)).to be true
      end
    end

    context 'when the specified column is empty' do
      before do
        grid = Array.new(7) { Array.new(6) }
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns false' do
        expect(board.column_full?(index)).to be false
      end
    end

    context 'when the specified column is almost full' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[index] = [token, token, token, token, token, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns false' do
        expect(board.column_full?(index)).to be false
      end
    end

    context 'when the specified column is almost empty' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[index] = [token, nil, nil, nil, nil, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns false' do
        expect(board.column_full?(index)).to be false
      end
    end
  end

  describe '#four_in_a_row?' do
    subject(:board) { described_class.new }
    let(:token) { :foo }

    context 'when there are four tokens in a horizontal line' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[0] = [token, nil, nil, nil, nil, nil]
        grid[1] = [token, nil, nil, nil, nil, nil]
        grid[2] = [token, nil, nil, nil, nil, nil]
        grid[3] = [token, nil, nil, nil, nil, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there are four tokens in a vertical line' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[0] = [token, token, token, token, nil, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there are four tokens in a positive diagonal line' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[0] = [token, nil, nil, nil, nil, nil]
        grid[1] = [nil, token, nil, nil, nil, nil]
        grid[2] = [nil, nil, token, nil, nil, nil]
        grid[3] = [nil, nil, nil, token, nil, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there are four tokens in a negative diagonal line' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[0] = [nil, nil, nil, token, nil, nil]
        grid[1] = [nil, nil, token, nil, nil, nil]
        grid[2] = [nil, token, nil, nil, nil, nil]
        grid[3] = [token, nil, nil, nil, nil, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end
  end

  describe '#place_token' do
  end
end
# rubocop: enable Metrics
