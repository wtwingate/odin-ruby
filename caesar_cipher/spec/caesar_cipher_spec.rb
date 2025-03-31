require_relative "../lib/caesar_cipher"

describe CaesarCipher do
  describe "#encrypt" do
    context "when message is a single word" do
      subject(:one_word) { described_class.new("hello") }

      it "handles small positive shifts" do
        result = one_word.encrypt(5)
        expect(result).to eq("mjqqt")
      end

      it "handles small negative shifts" do
        result = one_word.encrypt(-5)
        expect(result).to eq("czggj")
      end

      it "handles large positive shifts" do
        result = one_word.encrypt(42)
        expect(result).to eq("xubbe")
      end

      it "handles large negative shifts" do
        result = one_word.encrypt(-42)
        expect(result).to eq("rovvy")
      end
    end

    context "when message is a sentence" do
      subject(:sentence) { described_class.new("Hello, World!") }

      it "handles small positive shifts" do
        result = sentence.encrypt(5)
        expect(result).to eq("Mjqqt, Btwqi!")
      end

      it "handles small negative shifts" do
        result = sentence.encrypt(-5)
        expect(result).to eq("Czggj, Rjmgy!")
      end

      it "handles large positive shifts" do
        result = sentence.encrypt(42)
        expect(result).to eq("Xubbe, Mehbt!")
      end

      it "handles large negative shifts" do
        result = sentence.encrypt(-42)
        expect(result).to eq("Rovvy, Gybvn!")
      end
    end
  end
end
