describe Quandl::Result do
  TestRow = Struct.new(:close)
  let(:values) { [100, 90, 110, 105] }
  let(:result) { Quandl::Result.new values.map{ |val| TestRow.new(val.to_f) } }

  describe "drawdowns" do
    it "are correct" do
      expect(result.drawdowns.to_a).to eq [-0.1, -0.045454545454545456]
    end
  end

  describe "maximum drawdown" do
    it "is correct" do
      expect(result.maximum_drawdown).to eq -0.1
    end
  end

  describe "return" do
    it "is correct" do
      expect(result.return).to eq 5.0
    end
  end
end
