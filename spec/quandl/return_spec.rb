describe Quandl::Return do
  let(:first)    { Quandl::Result::Row.new("FB", Time.new(2017,2,3), 12.0, 13.0, 11.9, 12.2) }
  let(:last)     { Quandl::Result::Row.new("FB", Time.new(2017,2,5), 10.2, 10.4, 8.7, 9.2) }
  let(:returrrn) { Quandl::Return.new first, last }  # piratey, as return is reserved ;)

  it "calculates percentage correctly" do
    expect(returrrn.to_f).to eq -3.0  # 12.2 - 9.2
  end

  it "formats string" do
    expect(returrrn.to_s).to eq "-3.0 (12.2 on 03.02.17 -> 9.2 on 05.02.17)"
  end
end
