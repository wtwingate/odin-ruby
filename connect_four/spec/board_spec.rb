require_relative '../lib/board'

describe Board do
  describe "#full?" do
    subject(:board) { described_class.new }
    let(:token) { :foo }
    
    context "when the grid is full" do
      before do
        grid = Array.new(7) { Array.new(6) { token } }
        board.instance_variable_set(:@grid, grid)
      end
      
      it "returns true" do
        expect(board).to be_full
      end
    end

    context "when the grid is empty" do
      before do
        grid = Array.new(7) { Array.new(6) }
        board.instance_variable_set(:@grid, grid)        
      end
      
      it "returns false" do
        expect(board).not_to be_full
      end
    end

    context "when the grid is almost full" do
      before do
        grid = Array.new(7) { Array.new(6) { token } }
        grid[0][0] = nil
        board.instance_variable_set(:@grid, grid)
      end
      
      it "returns false" do
        expect(board).not_to be_full
      end
    end

    context "when the grid is almost empty" do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[0][0] = token
        board.instance_variable_set(:@grid, grid)        
      end
      
      it "returns false" do
        expect(board).not_to be_full
      end
    end
  end

  describe "#column_full?" do
    subject(:board) { described_class.new }
    let(:token) { :foo }
    let(:index) { 0 }

    context "when the specified column is full" do
      before do
        grid = Array.new(7) { Array.new(6) }
        grid[index] = Array.new(6) { token }
        board.instance_variable_set(:@grid, grid)
      end
      
      it "returns true" do
        expect(board.column_full?(index)).to be true
      end
    end
  end

  describe "#four_in_a_row?" do
  end
end
