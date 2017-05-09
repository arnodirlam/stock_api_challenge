require_relative '../quandl'

module Quandl
  # Represents a return resulting from a stock price difference,
  # holds context information about the start and end price,
  # and formats nicely with `to_f` and `to_s`
  class Return
    attr_reader :first, :last

    def initialize(first, last)
      @first = first
      @last = last
    end

    # Overrides casting this object to float
    def to_f
      last.close - first.close
    end

    # Overrides casting this object to string (used by Ruby methods such as print)
    def to_s
      "#{to_f} (#{first.close} on #{first.date.strftime("%d.%m.%y")} -> #{last.close} on #{last.date.strftime("%d.%m.%y")})"
    end
  end
end
