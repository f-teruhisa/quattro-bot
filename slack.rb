require 'slack-ruby-client'

  Slack.configure do |conf|
    conf.token = 'xoxb-37175438516-715733692496-dy45X6O4yRo23F9KW5lGXbjP'
  end

  client = Slack::RealTime::Client.new

  client.on :hello do
    puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
  end

  client.on :message do |data|
    case data.text
    when 'bot hi' then
      client.message(channel: data.channel, text: "Hi <@#{data.user}>!")
    when /^bot/ then
      client.message(channel: data.channel, text: "Sorry <@#{data.user}>, what?")
    end
  end

  client.start!