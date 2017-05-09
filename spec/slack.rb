describe Slack do
  let(:url) { "https://hooks.slack.com/services/abc/123/xyz" }

  it "issues HTTP POST" do
    # mock config method
    expect(Slack).to receive(:webhook_url).and_return(url)

    # mock HTTP request
    stub_request(:post, url)
      .to_return(status: 200)

    # trigger notification
    Slack.notify "test"

    # assert HTTP POST request
    expect(WebMock).to have_requested(:post, url)
      .with(body: /\Apayload=\{.*?\}\Z/)
  end
end
