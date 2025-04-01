# frozen_string_literal: true

require_relative '../lib/board'

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

    let(:token_one) { :foo }
    let(:token_two) { :bar }

    context 'when there are four tokens in a horizontal line' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[1] = [nil, nil, token_one, nil, nil, nil]
        grid[2] = [nil, nil, token_one, nil, nil, nil]
        grid[3] = [nil, nil, token_one, nil, nil, nil]
        grid[4] = [nil, nil, token_one, nil, nil, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there are four tokens in a vertical line' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[3] = [nil, token_one, token_one, token_one, token_one, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there are four tokens in a positive diagonal line' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[1] = [nil, token_one, nil, nil, nil, nil]
        grid[2] = [nil, nil, token_one, nil, nil, nil]
        grid[3] = [nil, nil, nil, token_one, nil, nil]
        grid[4] = [nil, nil, nil, nil, token_one, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there are four tokens in a negative diagonal line' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[1] = [nil, nil, nil, nil, token_one, nil]
        grid[2] = [nil, nil, nil, token_one, nil, nil]
        grid[3] = [nil, nil, token_one, nil, nil, nil]
        grid[4] = [nil, token_one, nil, nil, nil, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there are four tokens in a line on the left edge' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[0] = [nil, token_one, token_one, token_one, token_one, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there are four tokens in a line on the right edge' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[6] = [nil, token_one, token_one, token_one, token_one, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there are four tokens in a line on the top edge' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[1] = [nil, nil, nil, nil, nil, token_one]
        grid[2] = [nil, nil, nil, nil, nil, token_one]
        grid[3] = [nil, nil, nil, nil, nil, token_one]
        grid[4] = [nil, nil, nil, nil, nil, token_one]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there are four tokens in a line on the bottom edge' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[1] = [token_one, nil, nil, nil, nil, nil]
        grid[2] = [token_one, nil, nil, nil, nil, nil]
        grid[3] = [token_one, nil, nil, nil, nil, nil]
        grid[4] = [token_one, nil, nil, nil, nil, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there are more than four tokens in a line' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[0] = [token_one, token_one, token_one, token_one, token_one, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there is a diagonal line starting at the bottom-left corner' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[0] = [token_one, nil, nil, nil, nil, nil]
        grid[1] = [nil, token_one, nil, nil, nil, nil]
        grid[2] = [nil, nil, token_one, nil, nil, nil]
        grid[3] = [nil, nil, nil, token_one, nil, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there is a diagonal line ending at the top-right corner' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[3] = [nil, nil, token_one, nil, nil, nil]
        grid[4] = [nil, nil, nil, token_one, nil, nil]
        grid[5] = [nil, nil, nil, nil, token_one, nil]
        grid[6] = [nil, nil, nil, nil, nil, token_one]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there is a diagonal line starting at the top-left corner' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[0] = [nil, nil, nil, nil, nil, token_one]
        grid[1] = [nil, nil, nil, nil, token_one, nil]
        grid[2] = [nil, nil, nil, token_one, nil, nil]
        grid[3] = [nil, nil, token_one, nil, nil, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there is a diagonal line ending at the bottom-right corner' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[3] = [nil, nil, nil, token_one, nil, nil]
        grid[4] = [nil, nil, token_one, nil, nil, nil]
        grid[5] = [nil, token_one, nil, nil, nil, nil]
        grid[6] = [token_one, nil, nil, nil, nil, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when there are four tokens in a row multiple times' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[0] = [token_one, token_one, token_one, token_one, nil, nil]
        grid[1] = [nil, token_one, nil, token_one, nil, nil]
        grid[2] = [nil, nil, token_one, token_one, nil, nil]
        grid[3] = [nil, nil, nil, token_one, nil, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_four_in_a_row
      end
    end

    context 'when the board is empty' do
      before do
        grid = Array.new(7) { Array.new(6) }
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns false' do
        expect(board).not_to be_four_in_a_row
      end
    end

    context 'when there are four tokens not in a line' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[0] = [token_one, nil, nil, nil, nil, nil]
        grid[1] = [nil, token_one, nil, nil, nil, nil]
        grid[2] = [nil, nil, token_one, nil, nil, nil]
        grid[3] = [nil, nil, nil, nil, token_one, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns false' do
        expect(board).not_to be_four_in_a_row
      end
    end

    context 'when there is a gap in the middle of four tokens' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[0] = [token_one, token_one, nil, token_one, token_one, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns false' do
        expect(board).not_to be_four_in_a_row
      end
    end

    context 'when there are four tokens of different types in a row' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[0] = [token_one, token_two, token_one, token_two, nil, nil]
        grid[1] = [nil, nil, nil, nil, nil, nil]
        grid[2] = [nil, nil, nil, nil, nil, nil]
        grid[3] = [nil, nil, nil, nil, nil, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns false' do
        expect(board).not_to be_four_in_a_row
      end
    end
  end
end
