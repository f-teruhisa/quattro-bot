require 'slack-ruby-client'
require 'dotenv'

Dotenv.load

Slack.configure do |conf|
  conf.token = ENV['SLACK_API_TOKEN']
end

client = Slack::Web::Client.new
client.chat_postMessage(channel: '#connpass_notification', text: 'Hello World', as_user: true)

