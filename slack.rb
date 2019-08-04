require 'slack-ruby-client'

  Slack.configure do |conf|
    conf.token = 'xoxb-37175438516-715733692496-dy45X6O4yRo23F9KW5lGXbjP'
  end

  client = Slack::Web::Client.new
  client.chat_postMessage(channel: '#connpass_notification', text: 'Hello World', as_user: true)

