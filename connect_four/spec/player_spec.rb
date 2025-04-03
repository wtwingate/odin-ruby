# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new(1, 'X', 'Player 1') }

  describe '#input_name' do
    context 'when the player inputs a valid name' do
      before do
        allow(player).to receive(:puts)
        allow(player).to receive(:gets).and_return('Player 1')
      end

      it 'prompts the player to enter their name' do
        player.input_name
        expect(player).to have_received(:puts).with('Player 1: Please enter your name:')
      end

      it 'gets the player input' do
        player.input_name
        expect(player).to have_received(:gets).once
      end

      it 'returns the name' do
        expect(player.input_name).to eq('Player 1')
      end

      it 'does not print an error message' do
        player.input_name
        expect(player).not_to have_received(:puts).with('Please enter a valid name:')
      end
    end

    context 'when the player inputs an invalid name' do
      before do
        allow(player).to receive(:puts)
        allow(player).to receive(:gets).and_return('', 'Player 1')
      end

      it 'prompts the player to enter their name' do
        player.input_name
        expect(player).to have_received(:puts).with('Player 1: Please enter your name:')
      end

      it 'prints an error message' do
        player.input_name
        expect(player).to have_received(:puts).with('Please enter a valid name:').once
      end

      it 'gets the player input again' do
        player.input_name
        expect(player).to have_received(:gets).twice
      end

      it 'returns the valid name' do
        expect(player.input_name).to eq('Player 1')
      end
    end
  end
end
