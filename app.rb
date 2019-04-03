#!/usr/bin/ruby

=begin
  For example:
    - num_dots = 10
    - time = 0.5
=end
def loading(status,num_dots, time, left)
  dot = "."
  (1..num_dots).each do |i|
    puts "[#{(((status * 60).to_f - left) / 60).round(2)} minute[s] #{left.floor} second[s]] Loading#{dot*i}"
    sleep(time)
    system('clear')
  end
end

=begin
  For example:
    - current_time = Time.now
    - length = 10.0
=end
def timer(status,current_time, length)
  time = current_time
  while (1)
    now = Time.now
    current = (now - time)
    if current > length
      break
    else
      loading(status,5,0.5,current)
    end
  end
end

# Don't change, these are seconds
length = 60.0
# Number of minutes
number_of_minutes = 20

while (number_of_minutes > 0)
  timer(number_of_minutes,Time.now, length)
  number_of_minutes -= 1
  puts "Total time left #{number_of_minutes} minutes"
  sleep(2)
end
system('clear')
puts("Timer done.")
