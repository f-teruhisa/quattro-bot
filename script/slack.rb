require 'slack-ruby-client'
require 'dotenv'
require 'csv'

Dotenv.load

groups = []
numbers_of_group = ENV['NUMBERS_OF_GROUP'].to_i

def read_csv(members)
  members = []
  CSV.foreach('data/members.csv') do |member|
    members << member
  end
  return members
end

def create_groups(numbers_of_group, groups, members)
  numbers_of_group.times { create_group(groups) }
  split_members(members, numbers_of_group, groups)
end

def create_group(groups)
  empty_group = Array.new
  groups << empty_group
end

def split_members(members, numbers_of_group, groups)
  members.each_with_index do |member, i|
    number = i % numbers_of_group
    group = groups[number]
    assign_member_into_groups(group, number+1, member)
  end
end

def assign_member_into_groups(group, number, member)
  group << number
  group << member
end

Slack.configure do |conf|
  conf.token = ENV['SLACK_API_TOKEN']
end

members = read_csv(members)
create_groups(numbers_of_group, groups, members)

client = Slack::Web::Client.new
client.chat_postMessage(channel: '#connpass_notification', text: 'Hello World', as_user: true)
