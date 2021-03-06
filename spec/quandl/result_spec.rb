describe Quandl::Result do
  TestRow = Struct.new(:close, :high, :low)
  let(:values) { [100, 90, 110, 105] }
  let(:result) { Quandl::Result.new values.map{ |val| TestRow.new(val.to_f, val.to_f, val.to_f - 1) } }

  describe "drawdowns" do
    it "are correct" do
      expect(result.drawdowns.map(&:to_f)).to eq [-0.11, -0.05454545454545454]
    end
  end

  describe "maximum drawdown" do
    it "is correct" do
      expect(result.maximum_drawdown.to_f).to eq -0.11
    end
  end

  describe "return" do
    it "is correct" do
      expect(result.return.to_f).to eq 5.0
    end
  end
end
