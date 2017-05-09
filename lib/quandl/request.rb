require 'curb'
require_relative '../quandl'
require_relative 'result'

module Quandl
  # Builds and performs a request to the Quandl API,
  # parses the response and returns various methods to access it,
  # most notably returning a `Quandl::Result` object via `result`
  class Request
    attr_reader :ticker, :date_range

    def initialize(ticker, date_range)
      @ticker = ticker
      @date_range = date_range
    end

    # Issue the actual request, return `Quandl::Result` object
    def result
      if response_body
        Quandl::Result.new rows
      end
    end

    # Direct access to the (memoized) HTTP response body
    def response_body
      @response_body ||= if response = Curl.get(url)
        response.body_str
      end

    rescue Curl::Err::SSLConnectError, Curl::Err::HostResolutionError
      puts "Could not connect to Quandl API. Please try again"
      exit 1
    end

    # Direct access to the row objects returned.
    # These are passed to the `Quandl::Result` object in `result`
    def rows
      Enumerator.new do |y|
        CSV.parse(response_body, headers: :first_row, converters: [:numeric, :date]) do |row|
          y << Quandl::Result::Row.new(*row.fields)
        end
      end
    end

    # URL for this API request
    def url
      "#{endpoint}?date.gte=#{date_range.begin}&date.lte=#{date_range.end}&ticker=#{ticker}&api_key=#{Quandl.api_key}"
    end

    # Protocol, domain and path to build the API request URL
    def endpoint
      "https://www.quandl.com/api/v3/datatables/WIKI/PRICES.csv"
    end
  end
end
