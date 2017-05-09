require 'curb'
require_relative 'quandl/request'
require_relative 'quandl/result'

# Main entry point to querying the Quandl API.
# See `get_ticker` to learn more
module Quandl
  extend self  # all methods in here are class methods

  # Retrieve stock info for the given ticker at the given date range
  def get_ticker(ticker, date_range)
    request = Quandl::Request.new(ticker, date_range)
    response = request.perform
    Quandl::Result.new(response.body_str)
  end

  # Read API key for requests from environment
  def api_key
    ENV["API_KEY"] || raise(StandardError, "Please provide a Quandl API key via the env var: API_KEY")
  end
end
