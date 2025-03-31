require_relative '../lib/board'

describe Board do
  describe "#winner?" do
    context "when the first row is filled with the same mark" do
      before do
        squares = ['X', 'X', 'X', nil, nil, nil, nil, nil, nil]
        subject.instance_variable_set(:@squares, squares)
      end

      it "returns true" do
        expect(subject).to be_winner
      end
    end

    context "when the second row is filled with the same mark" do
      before do
        squares = [nil, nil, nil, 'X', 'X', 'X', nil, nil, nil]
        subject.instance_variable_set(:@squares, squares)
      end

      it "returns true" do
        expect(subject).to be_winner
      end
    end

    context "when the third row is filled with the same mark" do
      before do
        squares = [nil, nil, nil, nil, nil, nil, 'X', 'X', 'X']
        subject.instance_variable_set(:@squares, squares)
      end

      it "returns true" do
        expect(subject).to be_winner
      end
    end

    context "when the first column is filled with the same mark" do
      before do
        squares = ['X', nil, nil, 'X', nil, nil, 'X', nil, nil]
        subject.instance_variable_set(:@squares, squares)
      end

      it "returns true" do
        expect(subject).to be_winner
      end
    end

    context "when the second column is filled with the same mark" do
      before do
        squares = [nil, 'X', nil, nil, 'X', nil, nil, 'X', nil]
        subject.instance_variable_set(:@squares, squares)
      end

      it "returns true" do
        expect(subject).to be_winner
      end
    end

    context "when the third column is filled with the same mark" do
      before do
        squares = [nil, nil, 'X', nil, nil, 'X', nil, nil, 'X']
        subject.instance_variable_set(:@squares, squares)
      end

      it "returns true" do
        expect(subject).to be_winner
      end
    end

    context "when the first diagonal is filled with the same mark" do
      before do
        squares = ['X', nil, nil, nil, 'X', nil, nil, nil, 'X']
        subject.instance_variable_set(:@squares, squares)
      end

      it "returns true" do
        expect(subject).to be_winner
      end
    end

    context "when the second diagonal is filled with the same mark" do
      before do
        squares = [nil, nil, 'X', nil, 'X', nil, 'X', nil, nil]
        subject.instance_variable_set(:@squares, squares)
      end

      it "returns true" do
        expect(subject).to be_winner
      end
    end

    context "when the board is empty" do
      it "returns false" do
        expect(subject).not_to be_winner
      end
    end

    context "when the board is full, but there is no 'three in a row'" do
      before do
        squares = ['X', 'O', 'X', 'X', 'O', 'X', 'O', 'X', 'O']
        subject.instance_variable_set(:@squares, squares)
      end

      it "returns false" do
        expect(subject).not_to be_winner
      end
    end
  end
end
