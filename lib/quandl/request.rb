require_relative '../quandl'

module Quandl
  # Builds and performs a request to the Quandl API
  class Request
    attr_reader :ticker, :date_range

    def initialize(ticker, date_range)
      @ticker = ticker
      @date_range = date_range
    end

    # Issue the actual request, return HTTP response object
    def perform
      Curl.get(url)
    end

    # URL for this API request
    def url
      "#{endpoint}?date.gte=#{date_range.begin}&date.lte=#{date_range.end}&ticker=#{ticker}&api_key=#{Quandl.api_key}"
    end

    # Protocol, domain and path to build the API request URL
    def endpoint
      "https://www.quandl.com/api/v3/datatables/WIKI/PRICES.json"
    end
  end
end
