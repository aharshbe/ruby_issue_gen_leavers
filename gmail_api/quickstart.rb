#!/usr/bin/ruby

# Requires for Google api
require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'Gmail API Ruby Quickstart'.freeze
CREDENTIALS_PATH = 'credentials.json'.freeze
# The file token.yaml stores the user's access and refresh tokens, and is
# created automatically when the authorization flow completes for the first
# time.
TOKEN_PATH = 'token.yaml'.freeze
SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_READONLY

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials

def authorize
  client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(base_url: OOB_URI)
    puts 'Open the following URL in the browser and enter the ' \
         "resulting code after authorization:\n" + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
    )
  end
  credentials
end

# Initialize the API
service = Google::Apis::GmailV1::GmailService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

# user_id is user
user_id = 'me'

# Check to make sure user messages exist
result_messages = result_messages = service.list_user_messages(user_id)
puts 'No messages found' if result_messages.messages.empty?
arr_snippets = Array.new
message_ids = Array.new

# If messages exist, build array of messages
result_messages.messages.each {
  |message|
  puts "<--------------->"
  message_raw = message.raw
  get_message = service.get_user_message(user_id, message.id)
  arr_snippets.push(get_message.snippet)
  message_ids.push(message.id)
}
system('clear')
puts "Done parsing snippets from messages."

# Search for messages that have a given string, in this case hubber
s="Hubber"

hubberNames = Array.new
messagesToDelete = Array.new
number_of_s_found = 0
index = 0
arr_snippets.each {
  |snippet|
  if snippet.include? s
    number_of_s_found += 1
    oString = snippet.partition(':').last
    hubberName = oString.partition(':').first
    hubberNames.push(hubberName)
    messagesToDelete.push(index)
  end
  index += 1
}

puts "found, #{number_of_s_found} hubbers"
system("ruby create_github_issue.rb #{hubberNames}")



puts message_ids
puts messagesToDelete
current = 0
email_index = 0
message_ids.each {
  |email|
  if email_index == messagesToDelete[current]
    puts "Delelting..."
    system("python delete.py #{email}")
    current += 1
  else
    puts "Kepping email #{email} at #{email_index}"
  end
  email_index += 1
}
