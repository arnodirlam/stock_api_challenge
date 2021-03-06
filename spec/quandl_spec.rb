describe Quandl do
  let(:ticker) { "FB" }
  let(:date_range) { 20150101..20150201 }

  describe "get ticker", vcr: { cassette_name: "quandl/get_ticker", record: :new_episodes } do
    let(:result) { Quandl.get_ticker(ticker, date_range) }

    it "returns result object" do
      expect(result).to be_a Quandl::Result
    end

    it "returns maximum drawdown" do
      expect(result.maximum_drawdown.to_f).to eq -0.07199777905370021
    end

    it "returns return" do
      expect(result.return.to_f).to eq -2.5400000000000063
    end

    context "with Date Range" do
      let(:date_range) { Date.new(2015,1,1)..Date.new(2015,2,1) }

      it "returns result object" do
        expect(result).to be_a Quandl::Result
      end

      it "returns maximum drawdown" do
        expect(result.maximum_drawdown.to_f).to eq -0.07199777905370021
      end

      it "returns return" do
        expect(result.return.to_f).to eq -2.5400000000000063
      end
    end
  end
end
