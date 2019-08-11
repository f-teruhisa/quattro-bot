require 'slack-ruby-client'
require 'dotenv'
require 'csv'

Dotenv.load

Slack.configure do |conf|
  conf.token = ENV['SLACK_API_TOKEN']
end

groups, members = [], []
numbers_of_group = ENV['NUMBERS_OF_GROUP'].to_i

def load_members(members)
  read_csv(members)
  members.shuffle
end

def read_csv(members)
  CSV.foreach('data/members.csv') do |member|
    members << member
  end
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

members = load_members(members)
create_groups(numbers_of_group, groups, members)

client = Slack::Web::Client.new
client.chat_postMessage(channel: '#connpass_notification', text: 'Hello World', as_user: true)
