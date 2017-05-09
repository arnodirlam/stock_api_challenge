require 'json'
require_relative '../quandl'

module Quandl
  # Represents a result from the Quandl API
  class Result
    def initialize(body_str=nil)
      from_http_body! body_str if body_str
    end

    # Parse results from a Quandl API response body
    def from_http_body!(body_str)
      json = JSON.parse(body_str)
      puts JSON.pretty_generate(json)
    end
  end
end
