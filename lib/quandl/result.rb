require 'csv'
require_relative '../quandl'
require_relative 'drawdown'
require_relative 'return'

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

    # Returns enumerator of all the drawdowns
    # as negative floats (e.g. -0.1 for a drawdown of -10%)
    def drawdowns
      Enumerator.new do |y|
        peak, trough = nil, nil
        yield_drawdown = -> { y << Quandl::Drawdown.new(peak, trough) if trough }

        rows.each do |row|
          # mark new peak, report previous drawdown
          if peak.nil? or row.high > peak.high
            yield_drawdown.call
            peak, trough = row, nil
          end

          # mark new trough
          if trough.nil? or row.low < trough.low
            trough = row
          end
        end

        # report final drawdown
        yield_drawdown.call
      end
    end

    # Returns the maximum drawdown
    def maximum_drawdown
      self.drawdowns.min_by(&:to_f)
    end

    # Returns the financial return, i.e. price difference between start date and end date
    def return
      # Enumerator objects don't have `#last`, so we use the following
      Quandl::Return.new(rows.first, rows.reverse_each.first)
    end
  end
end
