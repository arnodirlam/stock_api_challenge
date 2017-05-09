require_relative 'lib/quandl'
require_relative 'lib/slack'

ticker = ARGV.first
date_start_or_range = ARGV[1..-1].join(' ')

result = Quandl.get_ticker(ticker, date_start_or_range)
result.rows.lazy.each do |row|
  puts "#{row.date.strftime("%d.%m.%y")}: Closed at #{row.close} (#{row.low} ~ #{row.high})"
end

puts ""
puts "First 3 Drawdowns:"
result.drawdowns.lazy.take(3).each{ |drawdown| puts drawdown }

puts ""
puts "Maximum drawdown: #{result.maximum_drawdown}"
puts "Return: #{result.return}"

Slack.notify result,
  "Return: #{result.return}",
  "Maximum drawdown: #{result.maximum_drawdown}"
