#!/usr/bin/ruby

require 'octokit'
require 'dotenv'

# Load .env file
Dotenv.load

def create_issue(hubber, body)
  # Set access_token instead of login and password if you use personal access token
  client = Octokit::Client.new(:access_token => ENV['access_token'])

  # Fetch the current user
  user = client.user "aharshbe"
  assignee = user[:assignee]
  client.create_issue("github/it", "Hubber #{hubber} needs stuff deleted",body)
end

# Parse arguments to get hubbers
args = Array.new
ARGV.each {
  |argv|
  # Remove commas
  if argv.include? '['
    args.push(argv.partition('[').last)
  elsif argv.include? ']'
    args.push(argv.partition(']').first)
  else
    args.push(argv)
  end
}
args.each {
  |person|
  body = ''
  name = person.partition(',').first
  date = person.partition(',').last
  date_final = date.partition(',').first
  handle = date.partition(',').last
  # remove comma at end of handle
  handle = handle.gsub(/,/,"")
  if name.length() > 0
    puts name
  end
  if date_final.length() > 0
    puts date_final
    body += date_final+' '
  end
  if handle.length() > 0
    puts handle
    body += handle
  end
  create_issue(name, body)
}
