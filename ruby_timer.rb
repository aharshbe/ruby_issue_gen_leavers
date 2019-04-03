#!/usr/bin/ruby

=begin
Created by:
  Austin Harshberger
  GitHub, 2019
  Free and open source
=end

=begin
Intention:
  - Intented to be used as a pseudo-cron job
  - Example: place in a loop of your choice and get the same functionality as a cron job without the headache
=end

=begin
  For example:
    - status = 3: Number of minutes
    - num_dots = 10: Number of dots for loading screen
    - time = 0.5: Time between dot loading times, ie., speed of loading screen
    - left = 60: Amount of seconds, don't change this if you want to measure based on minutes
    - passed = varibale: Amount of minutes past
=end
def loading(status,num_dots, time, left, passed)
  dot = "."
  (1..num_dots).each do |i|
    puts "#{(((status * 60).to_f - left) / 60).round(2)} minute[s] left"
    puts "#{passed}:#{((left)).round(2)} second[s] lapsed"
    puts "Loading#{dot*i}"
    sleep(time)
    system('clear')
  end
end

=begin
  For example:
    - status = 3: minutes
    - current_time = Time.now
    - length = 60.0: seconds, don't change
=end
def timer(status,current_time, length, passed)
  time = current_time
  prev = 0
  while (1)
    now = Time.now
    current = (now - time)
    if current > length
      break
    else
      loading(status, 5, 0.5, current, passed)
      prev += 1
    end
  end
end

=begin
  For example:
    - minutes 3: for a 3 minute timer
=end
def start_timer(minutes)
  # Don't change -- based metric, seconds
  length = 60.0
  # Number of minutes
  number_of_minutes = minutes
  passed = 0
  while (number_of_minutes > 0)
    timer(number_of_minutes,Time.now, length, passed)
    number_of_minutes -= 1
    passed += 1
    puts "Total time left #{number_of_minutes} minutes"
    sleep(2)
  end
  system('clear')
  puts("Timer done -- #{number_of_minutes} passed.")
end

# Creating timer based on amount of time input by user
puts("How many minutes would you like to time for?")
time = gets.chomp
start_timer(time.to_i)
