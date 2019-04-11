# Offboarding automation for GitHub employees
## Purpose
- Automate the creation of a GitHub issue when a GitHub employee leaves

### Dependencies:
* Ruby installed
* Python 2.7+ installed
* Gems:
	- Ocotokit
	- dotenv
* Permission/Auth for the Google account to automation received emails
* Automation is kicked off via Workday notification sent to specified email `itautomation*`

### Tips:
* If you're having trouble with GMAIL API auth, refer to pages:
	- [For Ruby auth](https://developers.google.com/gmail/api/quickstart/ruby)
	- [For Python deletion auth](https://developers.google.com/gmail/api/v1/reference/users/messages/delete#python)

### Usage:
* `git clone https://github.com/aharshbe/ruby_issue_gen_leavers`
* `cd ruby_issue_gen_leavers`
* `cd gmail_api/`
* run app `./quickstart.rb`


#### Authors:
* [Austin Harshberger](https://github.com/aharshbe)

