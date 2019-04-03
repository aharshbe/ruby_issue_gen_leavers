#!/usr/bin/ruby

require 'octokit'

client = Octokit::Client.new \
  :login    => 'aharshbe',
  :password => 'githubiscool2018Austin'

user = client.user("744afe2ab3d5ee28d615", :headers => { "X-GitHub-OTP" => "90cfd5a1ca50659609748224e6d78ac1e768c249" })
