#!/usr/bin/ruby

require 'octokit'
require 'dotenv'

# Load .env file
Dotenv.load

# Set access_token instead of login and password if you use personal access token
client = Octokit::Client.new(:access_token => ENV['access_token'])

# Fetch the current user
user = client.user "aharshbe"
puts(user.name)
puts(user[:company])
assignee = user[:assignee]

client.create_issue("github/it", 'User needs stuff deleted','Test body')
