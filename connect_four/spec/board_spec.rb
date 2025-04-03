# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#place_token' do
    subject(:board) { described_class.new }

    let(:grid) { board.instance_variable_get(:@grid) }
    let(:token) { 'X' }
    let(:col_idx) { 0 }

    context 'when the selected column is empty' do
      before do
        grid[col_idx] = [nil, nil, nil, nil, nil, nil]
      end

      it 'drops token into the first slot' do
        expect { board.place_token(token, col_idx) }
          .to change { grid[col_idx] }
          .from([nil, nil, nil, nil, nil, nil])
          .to([token, nil, nil, nil, nil, nil])
      end
    end

    context 'when the selected column is almost empty' do
      before do
        grid[col_idx] = [token, nil, nil, nil, nil, nil]
      end

      it 'drops token into the second slot' do
        expect { board.place_token(token, col_idx) }
          .to change { grid[col_idx] }
          .from([token, nil, nil, nil, nil, nil])
          .to([token, token, nil, nil, nil, nil])
      end
    end

    context 'when the selected column is almost full' do
      before do
        grid[col_idx] = [token, token, token, token, token, nil]
      end

      it 'drops token into the last slot' do
        expect { board.place_token(token, col_idx) }
          .to change { grid[col_idx] }
          .from([token, token, token, token, token, nil])
          .to([token, token, token, token, token, token])
      end
    end

    context 'when the selected column is full' do
      it 'raises an error' do
        grid = board.instance_variable_get(:@grid)
        column = [token, token, token, token, token, token]
        grid[col_idx] = column

        expect { board.place_token(token, col_idx) }.to raise_error(RuntimeError)
      end
    end
  end

  describe '#valid_move?' do
    subject(:board) { described_class.new }

    let(:token) { 'X' }
    let(:col_idx) { 0 }

    context 'when the specified column is empty' do
      before do
        grid = Array.new(7) { Array.new(6) }
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board.valid_move?(col_idx)).to be true
      end
    end

    context 'when the specified column is almost empty' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[col_idx] = [token, nil, nil, nil, nil, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board.valid_move?(col_idx)).to be true
      end
    end

    context 'when the specified column is almost full' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[col_idx] = [token, token, token, token, token, nil]
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board.valid_move?(col_idx)).to be true
      end
    end

    context 'when the specified column is full' do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[col_idx] = Array.new(6) { token }
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns false' do
        expect(board.valid_move?(col_idx)).to be false
      end
    end

    context 'when given an invalid column index' do
      it 'returns false for underflow values' do
        expect(board.valid_move?(-1)).to be false
      end

      it 'returns false for overflow values' do
        expect(board.valid_move?(7)).to be false
      end
    end
  end

  describe '#full?' do
    subject(:board) { described_class.new }

    let(:token) { 'X' }

    context 'when the grid is empty' do
      before do
        grid = Array.new(7) { Array.new(6) }
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

    context 'when the grid is full' do
      before do
        grid = Array.new(7) { Array.new(6) { token } }
        board.instance_variable_set(:@grid, grid)
      end

      it 'returns true' do
        expect(board).to be_full
      end
    end
  end

  describe '#four_in_a_row?' do
    subject(:board) { described_class.new }

    let(:token_one) { 'X' }
    let(:token_two) { 'O' }

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
