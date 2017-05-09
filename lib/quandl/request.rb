require 'curb'
require_relative '../quandl'
require_relative 'result'

module Quandl
  # Builds and performs a request to the Quandl API,
  # parses the response and returns various methods to access it,
  # most notably returning a `Quandl::Result` object via `result`
  class Request
    attr_reader :ticker, :date_range

    def initialize(ticker, start_date_or_range)
      @ticker = ticker

      @date_range = case start_date_or_range
        when /(.*?)(\.\.|\-)(.*)/
          cast_date($1.strip)..cast_date($3.strip)
        when Range
          cast_date(start_date_or_range.begin)..cast_date(start_date_or_range.end)
        else
          cast_date(start_date_or_range)..Date.today
      end
    end

    def cast_date(date_or_int)
      case date_or_int
        when Date then date_or_int
        when 19000101..30000101
          Date.new(date_or_int / 10_000, (date_or_int % 10_000) / 100, date_or_int % 100)
        when Integer  # Unix timestamp
          Time.at(date_or_int).to_date
        when /\A(\d{4})(\d{2})(\d{2})\Z/
          Date.new($1.to_i, $2.to_i, $3.to_i)
        else
          begin
            Date.parse(date_or_int)
          rescue ArgumentError => e
            raise ArgumentError, "#{e}: #{date_or_int.inspect}"
          end
      end
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
      "#{endpoint}?date.gte=#{date_range.begin.strftime("%Y%m%d")}&date.lte=#{date_range.end.strftime("%Y%m%d")}&ticker=#{ticker}&api_key=#{Quandl.api_key}"
    end

    # Protocol, domain and path to build the API request URL
    def endpoint
      "https://www.quandl.com/api/v3/datatables/WIKI/PRICES.csv"
    end
  end
end
