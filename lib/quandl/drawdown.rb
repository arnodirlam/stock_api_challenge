require_relative '../quandl'

module Quandl
  # Represents a drawdown in stock prices, holds
  # context information about the peak and trough,
  # and formats nicely with `to_f` and `to_s`
  class Drawdown
    attr_reader :peak, :trough

    def initialize(peak, trough)
      @peak = peak
      @trough = trough
    end

    # Overrides casting this object to float
    def to_f
      (trough.low - peak.high) / peak.high
    end

    # Overrides casting this object to string (used by Ruby methods such as print)
    def to_s
      "#{(to_f * 100).round(1)}% (#{peak.high} on #{peak.date.strftime("%d.%m.%y")} -> #{trough.low} on #{trough.date.strftime("%d.%m.%y")})"
    end
  end
end
