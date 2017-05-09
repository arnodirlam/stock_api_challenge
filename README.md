# stock_api_challenge
API client for stock prices in a CLI


## Task

### Your Task

Your task is to build a small application that can be interacted with through the command line.
The app should take a stock symbol, e.g. "AAPL", and a start date as an input.
It should calculate the **return** the stock has generated since the **start date to today** as well as the **maximum drawdown**
of the stock within that time frame. As an input for financial data, you can use Quandl's Wiki [EOD Stock Prices](https://www.quandl.com/data/WIKI).
It is up to you how you inform the user about this information but it should be more than a simple print output.
You could, for example, send it through email, tweet it on Twitter or push it to StockTwits. Be creative!

### Our Challenge

Our challenge is to write an application that interacts with the Quandl API and at least one other kind of API
(Email, Twitter, StockTwits, ...). The constraint is that your code should be written in Ruby.
Feel free to use gems but we ask you not to use any Quandl-specific gems like the official Ruby implementation.
Instead, please build the JSON API integration on your own with the help of generic gems if you like.

### The Deliverables

The deliverables are the code as well as a short description of what we need to do to run it.


## Setup

* Install [RVM](https://rvm.io/)
  ```
  curl -sSL https://get.rvm.io | bash -s stable
  ```
* Setup project
  ```
  cd .
  gem install bundler --no-ri --no-rdoc
  bundle
  ```

## Usage

You need an **Quandl API key** to run the command-line tool and tests.
Provide it via the `API_KEY` environment variable (see below).

To get an example output, run `API_KEY=XYZ ruby stock.rb`.

To run the tests: `API_KEY=XYZ rspec`.
