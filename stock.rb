require_relative 'lib/quandl'

Quandl.get_ticker("FB", 20150101..20150102)
