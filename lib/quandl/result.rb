require 'csv'
require_relative '../quandl'

module Quandl
  # Represents a result from the Quandl API
  class Result
    Row = Struct.new(:ticker, :date, :open, :high, :low, :close, :volume, :ex_dividend, :split_ratio, :adj_open, :adj_high, :adj_low, :adj_close, :adj_volume)

    def initialize(rows)
      @rows = rows
    end

    # Return lazy enumerator on the result rows
    def rows
      @rows.lazy
    end

    # Return lazy enumerator on the result prices
    def prices
      rows.map(&:close)
    end

    # Returns enumerator of all the drawdowns
    # as negative floats (e.g. -0.1 for a drawdown of -10%)
    def drawdowns
      Enumerator.new do |y|
        peak, trough = 0, nil
        yield_drawdown = -> { y << (trough - peak) / peak if trough }

        rows.each do |row|
          # mark new peak, report previous drawback
          if row.high > peak
            yield_drawdown.call
            peak, trough = row.high, nil
          end

          # mark new trough
          if trough.nil? or row.low < trough
            trough = row.low
          end
        end

        # report final drawback
        yield_drawdown.call
      end
    end

    # Returns the maximum drawdown
    def maximum_drawdown
      self.drawdowns.min
    end

    # Returns the financial return, i.e. price difference between start date and end date
    def return
      # Enumerator objects don't have `#last`, so we use the following
      prices.reverse_each.first - prices.first
    end
  end
end
