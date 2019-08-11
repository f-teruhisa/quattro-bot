require 'slack-ruby-client'
require 'dotenv'
require 'csv'

Dotenv.load

groups, members = [], []
numbers_of_group = ENV['NUMBERS_OF_GROUP'].to_i

def setup_slack
  set_slack_api_token
  client = Slack::Web::Client.new
  return client
end

def set_slack_api_token
  Slack.configure do |conf|
    conf.token = ENV['SLACK_API_TOKEN']
  end
end

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
  generate_csv_file(members, numbers_of_group, groups)
end

def create_group(groups)
  empty_group = Array.new
  groups << empty_group
end

def generate_csv_file(members, numbers_of_group, groups)
  grouped_members_csv = CSV.generate do |csv|
    split_members(members, numbers_of_group, groups)
    csv << groups
  end
  save_csv_file(grouped_members_csv)
end

def split_members(members, numbers_of_group, groups)
  members.each_with_index do |member, i|
    number = i % numbers_of_group
    group = groups[number]
    assign_member_into_groups(group, number+1, member)
  end
  return groups
end

def assign_member_into_groups(group, number, member)
  group << number
  group << member
end

def save_csv_file(grouped_members_csv)
  File.open('data/grouped_members_csv', 'w') do |file|
    file.write(grouped_members_csv)
  end
end

client = setup_slack
members = load_members(members)
create_groups(numbers_of_group, groups, members)
client.chat_postMessage(channel: '#connpass_notification', text: 'Hello World', as_user: true)
