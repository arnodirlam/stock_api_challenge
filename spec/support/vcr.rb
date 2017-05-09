VCR.configure do |c|
  #the directory where your cassettes will be saved
  c.cassette_library_dir = 'spec/vcr'

  # your HTTP request service.
  c.hook_into :webmock

  # Configure using rspec metadata key :vcr
  c.configure_rspec_metadata!
end
