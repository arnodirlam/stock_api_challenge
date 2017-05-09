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

  describe "initialize" do
    let(:ticker) { "FB" }

    it "supports Date..Date" do
      expect(Quandl::Request.new(ticker, Date.new(2015,1,1)..Date.new(2016,1,1)).date_range).to eq Date.new(2015,1,1)..Date.new(2016,1,1)
    end

    it "supports Int..Int" do
      expect(Quandl::Request.new(ticker, 20150101..20160101).date_range).to eq Date.new(2015,1,1)..Date.new(2016,1,1)
    end

    it "supports timestamp..timestamp" do
      expect(Quandl::Request.new(ticker, 1420066800..1451602800).date_range).to eq Date.new(2015,1,1)..Date.new(2016,1,1)
    end

    it "supports dense String..String" do
      expect(Quandl::Request.new(ticker, "20150101".."20160101").date_range).to eq Date.new(2015,1,1)..Date.new(2016,1,1)
    end

    it "supports dense String..String with dashes" do
      expect(Quandl::Request.new(ticker, "2015-01-01".."2016-01-01").date_range).to eq Date.new(2015,1,1)..Date.new(2016,1,1)
    end

    it "supports dense String..String as String" do
      expect(Quandl::Request.new(ticker, "20150101..20160101").date_range).to eq Date.new(2015,1,1)..Date.new(2016,1,1)
    end

    it "supports human-readable String..String" do
      expect(Quandl::Request.new(ticker, "Jan 1, 2015".."Jan 1, 2016").date_range).to eq Date.new(2015,1,1)..Date.new(2016,1,1)
    end

    it "supports human-readable start-end String" do
      expect(Quandl::Request.new(ticker, "Jan 1, 2015 - Jan 1, 2016").date_range).to eq Date.new(2015,1,1)..Date.new(2016,1,1)
    end

    it "supports Date" do
      expect(Quandl::Request.new(ticker, Date.new(2015,1,1)).date_range).to eq Date.new(2015,1,1)..Date.today
    end

    it "supports Int" do
      expect(Quandl::Request.new(ticker, 20150101).date_range).to eq Date.new(2015,1,1)..Date.today
    end

    it "supports dense String" do
      expect(Quandl::Request.new(ticker, "20150101").date_range).to eq Date.new(2015,1,1)..Date.today
    end

    it "supports human-readable String" do
      expect(Quandl::Request.new(ticker, "Jan 1, 2015").date_range).to eq Date.new(2015,1,1)..Date.today
    end
  end
end
