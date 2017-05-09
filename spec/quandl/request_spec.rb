describe Quandl::Request, vcr: { cassette_name: "quandl/request" } do
  let(:request) { Quandl::Request.new("FB", 20150101..20150201) }

  describe "rows" do
    it "returns an Enumerator" do
      expect(request.rows).to be_a Enumerator
    end

    it "returns rows with numeric close attribute" do
      expect(request.rows.lazy.map(&:close)).to all be > 0
    end
  end
end
