require_relative 'lib/quandl'

result = Quandl.get_ticker("FB", 20150101..20150201)
result.rows.lazy.each do |row|
  puts "#{row.date.strftime("%d.%m.%y")}: Closed at #{row.close} (#{row.low} ~ #{row.high})"
end

puts "Maximum drawdown: #{result.maximum_drawdown}"
puts "Return: #{result.return}"
