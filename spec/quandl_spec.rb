describe Quandl do
  let(:ticker) { "FB" }
  let(:date_range) { 20150101..20150102 }

  describe "get ticker" do
    it "returns result object", vcr: { cassette_name: "quandl/get_ticker" } do
      result = Quandl.get_ticker(ticker, date_range)
      expect(result).to be_a Quandl::Result
    end
  end
end
