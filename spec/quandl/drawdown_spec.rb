describe Quandl::Drawdown do
  let(:peak)     { Quandl::Result::Row.new("FB", Time.new(2017,2,3), 12.0, 13.0, 11.9) }
  let(:trough)   { Quandl::Result::Row.new("FB", Time.new(2017,2,5), 10.2, 10.4, 8.7) }
  let(:drawdown) { Quandl::Drawdown.new peak, trough }

  it "calculates percentage correctly" do
    expect(drawdown.to_f).to eq -0.3307692307692308  # (8.7 - 13) / 13
  end

  it "formats string" do
    expect(drawdown.to_s).to eq "-33.1% (13.0 on 03.02.17 -> 8.7 on 05.02.17)"
  end
end
