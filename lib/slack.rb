require 'curb'
require 'json'

module Slack
  extend self  # all methods in here are class methods

  def notify(*lines)
    return false unless active?

    payload = {
      channel: channel,
      username: username,
      icon_emoji: emoji,
      text: lines.map(&:to_s).join("\n")
    }

    Curl.post(webhook_url, payload: payload.to_json)
  end

  def active?
    webhook_url != ""
  end

  def webhook_url
    ENV["SLACK_URL"]
  end

  def channel
    ENV["SLACK_CHANNEL"] || "#random"
  end

  def username
    ENV["SLACK_USER"] || "Stockbot"
  end

  def emoji
    ENV["SLACK_EMOJI"] || ":rocket:"
  end
end
