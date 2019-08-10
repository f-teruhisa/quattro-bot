require 'slack-ruby-client'
require 'dotenv'
require 'csv'

Dotenv.load

members, groups = [], []
numbers_of_group = ENV['NUMBERS_OF_GROUP'].to_i

CSV.foreach('data/members.csv', headers: true) do |member|
  members << member
end

numbers_of_group.times do
  empty_group = Array.new
  groups << empty_group
end

members.each_with_index do |member, i|
  number = i % numbers_of_group
  group = groups[number]
  group << number
  group << member
end

Slack.configure do |conf|
  conf.token = ENV['SLACK_API_TOKEN']
end

client = Slack::Web::Client.new
client.chat_postMessage(channel: '#connpass_notification', text: 'Hello World', as_user: true)
