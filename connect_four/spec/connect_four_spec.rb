# frozen_string_literal: true

require_relative '../lib/connect_four'
require_relative '../lib/board'
require_relative '../lib/player'

describe ConnectFour do
  subject(:game) { described_class.new(player_one, player_two) }

  let(:player_one) { Player.new('Player 1', 'X') }
  let(:player_two) { Player.new('Player 2', 'O') }

  describe '#player_input' do
    context 'when the player inputs a valid column number' do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive_messages(gets: '1', valid_input?: true)
      end

      it 'prompts the player to choose a column' do
        game.player_input
        expect(game).to have_received(:puts).with("#{player_one.name}: Choose a column (1-7):")
      end

      it 'gets the player input' do
        game.player_input
        expect(game).to have_received(:gets).once
      end

      it 'returns the corresponding column index' do
        expect(game.player_input).to eq(0)
      end
    end

    context 'when the player inputs an invalid column number' do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('8', '7')
        allow(game).to receive(:valid_input?).and_return(false, true)
      end

      it 'displays an error message' do
        game.player_input
        expect(game).to have_received(:puts).with("You can't place a token there! Try again.").once
      end

      it 'prompts the player to choose a column again' do
        game.player_input
        expect(game).to have_received(:puts).with("#{player_one.name}: Choose a column (1-7):").twice
      end

      it 'gets the player input again' do
        game.player_input
        expect(game).to have_received(:gets).twice
      end

      it 'returns the corresponding column index' do
        expect(game.player_input).to eq(6)
      end
    end
  end

  describe '#valid_input?' do
    let(:board) { instance_double(Board) }

    before do
      game.instance_variable_set(:@board, board)
    end

    context 'when the player enters a column number that is not full' do
      it 'returns true' do
        allow(board).to receive(:valid_move?).and_return(true)
        input = '1'
        expect(game.valid_input?(input)).to be true
      end
    end

    context 'when the player enters a column number that is full' do
      it 'returns false' do
        allow(board).to receive(:valid_move?).and_return(false)
        input = '1'
        expect(game.valid_input?(input)).to be false
      end
    end

    context 'when the player enters an invalid column number' do
      it 'returns false for numbers that are too low' do
        input = '0'
        expect(game.valid_input?(input)).to be false
      end

      it 'returns false for numbers that are too high' do
        input = '8'
        expect(game.valid_input?(input)).to be false
      end
    end

    context 'when the player enters a string' do
      it 'returns false' do
        input = 'duck'
        expect(game.valid_input?(input)).to be false
      end
    end

    context 'when the player enters nothing' do
      it 'returns false' do
        input = ''
        expect(game.valid_input?(input)).to be false
      end
    end
  end

  describe '#game_over?' do
    let(:board) { instance_double(Board) }

    before do
      game.instance_variable_set(:@board, board)
    end

    context 'when the board is full and there are four tokens in a row' do
      before do
        allow(board).to receive_messages(full?: true, four_in_a_row?: true)
      end

      it 'returns true' do
        expect(game).to be_game_over
      end
    end

    context 'when the board is not full and there are four tokens in a row' do
      before do
        allow(board).to receive_messages(full?: false, four_in_a_row?: true)
      end

      it 'returns true' do
        expect(game).to be_game_over
      end
    end

    context 'when the board is full and there are not four tokens in a row' do
      before do
        allow(board).to receive_messages(full?: true, four_in_a_row?: false)
      end

      it 'returns true' do
        expect(game).to be_game_over
      end
    end

    context 'when the board is not full and there are not four tokens in a row' do
      before do
        allow(board).to receive_messages(full?: false, four_in_a_row?: false)
      end

      it 'returns true' do
        expect(game).not_to be_game_over
      end
    end
  end

  describe '#next_player' do
    context 'when Player One is the current player' do
      before do
        game.instance_variable_set(:@current_player, player_one)
      end

      it 'returns Player Two' do
        expect(game.next_player).to eq(player_two)
      end
    end

    context 'when Player Two is the current player' do
      before do
        game.instance_variable_set(:@current_player, player_two)
      end

      it 'returns Player One' do
        expect(game.next_player).to eq(player_one)
      end
    end
  end
end
