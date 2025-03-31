require_relative '../lib/tic_tac_toe'
require_relative '../lib/board'

describe TicTacToe do
  subject(:game) { described_class.new }
  let(:board) { instance_double(Board) }

  describe "#game_over?" do
    context "when there is no winner and there are turns remaining" do
      before do
        allow(board).to receive(:winner?).and_return(false)
        game.instance_variable_set(:@board, board)
        game.instance_variable_set(:@turn, 7)
      end

      it "returns false" do
        expect(game).not_to be_game_over
      end
    end

    context "when there is a winner and there are turns remaining" do
      before do
        allow(board).to receive(:winner?).and_return(true)
        game.instance_variable_set(:@board, board)
        game.instance_variable_set(:@turn, 7)
      end

      it "returns true" do
        expect(game).to be_game_over
      end
    end

    context "when there is no winner and there are no turns remaining" do
      before do
        allow(board).to receive(:winner?).and_return(false)
        game.instance_variable_set(:@board, board)
        game.instance_variable_set(:@turn, 9)
      end

      it "returns true" do
        expect(game).to be_game_over
      end
    end

    context "where there is a winner and there are no turns remaining" do
      before do
        allow(board).to receive(:winner?).and_return(true)
        game.instance_variable_set(:@board, board)
        game.instance_variable_set(:@turn, 9)
      end

      it "returns true" do
        expect(game).to be_game_over
      end
    end
  end

  describe "#user_input" do
    context "when a user enters an empty square number" do
      before do
        allow(game).to receive(:gets).and_return("1")
        allow(board).to receive(:square_empty?).and_return(true)
        game.instance_variable_set(:@board, board)
      end

      it "returns the corresponding empty square index" do
        result = game.user_input
        expect(result).to eq(0)
      end
    end

    context "when a user enters a filled square number" do
      before do
        allow(game).to receive(:gets).and_return("1", "2")
        allow(board).to receive(:square_empty?).and_return(false, true)
        game.instance_variable_set(:@board, board)
      end

      it "prompts the user for input again" do
        expect(game).to receive(:gets).twice
        game.user_input
      end
    end

    context "when a user does not enter a square number" do
      before do
        allow(game).to receive(:gets).and_return("W", "42", "3")
        allow(board).to receive(:square_empty?).and_return(true)
        game.instance_variable_set(:@board, board)
      end

      it "prompts the user for input again" do
        expect(game).to receive(:gets).exactly(3).times
        game.user_input
      end
    end

    context "when a user enters invalid inputs, then a valid input" do
      before do
        allow(game).to receive(:gets).and_return("W", "42", "quack", "1", "7")
        allow(board).to receive(:square_empty?).and_return(false, true)
        game.instance_variable_set(:@board, board)
      end

      it "prompts the user for input again" do
        expect(game).to receive(:gets).exactly(5).times
        game.user_input
      end

      it "returns the corresponding empty square index" do
        result = game.user_input
        expect(result).to eq(6)
      end
    end
  end

  describe "#place_mark" do
    context "on the first turn of the game" do
      before do
        allow(board).to receive(:place_mark)
        game.instance_variable_set(:@board, board)
        game.instance_variable_set(:@turn, 0)
      end
      
      it "places an 'X' on the board" do
        player_mark = 'X'
        square_index = 3
        expect(board).to receive(:place_mark).with(player_mark, square_index)
        game.place_mark(square_index)
      end
    end

    context "on the second turn of the game" do
      before do
        allow(board).to receive(:place_mark)
        game.instance_variable_set(:@board, board)
        game.instance_variable_set(:@turn, 1)
      end
      
      it "places on 'O' on the board" do
        player_mark = 'O'
        square_index = 4
        expect(board).to receive(:place_mark).with(player_mark, square_index)
        game.place_mark(square_index)
      end
    end
  end
end
