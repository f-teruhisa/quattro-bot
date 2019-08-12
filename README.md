# quattro-bot
# Description
- “Random lunch” is a method of activating communication inside the company
- quattro-bot solves communication challenges in your organization with random lunch

# Command Line App
quattro-bot is an application that runs on the command line.
You can execute the following command to divide the preset members into groups by script and notify the Slack channel.

```
ruby script/slack.rb
```

# Configure
## .env
You need some settings before running this application. 
Create an `.env` file and make the following settings.
This application reads environment variables set using `Dotenv` .

```
SLACK_API_TOKEN= 
NUMBERS_OF_GROUP=
CHANNEL=
COMMENT=
```
### SLACK_API_TOKEN
- Set the token value to communicate with Slack API
- Please refer to the following help page for token acquisition

[Create and regenerate API tokens](https://get.slack.help/hc/en-us/articles/215770388-Create-and-regenerate-API-tokens)

### NUMBERS_OF_GROUP
- Set the number of lunch groups as numeric data

### CHANNEL
- Write the channel you want to send Slack notifications, including `#`

### COMMENT
- Set the comment of bot when notifying grouped CSV files
- When setting a multi-line comment including a line break, enclose the character string with double quotations

## csv
The operation of this application involves the following two CSV files.

### data/members.csv
- This is a csv file that lists the members participating in the lunch
- Write a separate line for each member (headers and commas are not required)
- Sample data has been uploaded, so please refer to it when setting

[data/members.csv](https://github.com/f-teruhisa/quattro-bot/blob/master/data/members.csv)

### data/grouped_members.csv
- After the script is executed without any problem, it is automatically output
- List of members after grouping
- This CSV file is attached and sent to the configured Slack channel

# Dependency
- [slack-ruby-client](https://github.com/slack-ruby/slack-ruby-client)
- [csv](https://github.com/ruby/csv)
- [dotenv](https://github.com/bkeepers/dotenv)

# Author
[f-teruhsia](https://github.com/f-teruhisa)
