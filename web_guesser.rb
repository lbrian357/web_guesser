require 'sinatra'
require 'sinatra/reloader' #reloads server immediately after change in rb

class Counter
  attr_writer :count
  @@count = 6
  def initialize
    @@count = 6 if @@count == 1
    @@count -= 1
  end
  def self.count
    @@count
  end
end

cheat = false
number = rand(101)
=begin
get '/' do
  'Hello world!'
  #cheat = true
end
=end

get '/' do
  Counter.new
  count = Counter.count
  number = rand(101) if count == 5
  guess = params['guess'].to_i 
  message = check_guess(guess, number)
  b_color = change_color(message)
  if request.query_string =~ /&cheat=true/
    cheat = true
  else
    cheat = false
  end
  erb :index, :locals => {:number => number, :message => message, :b_color => b_color, :count => count, :cheat => cheat} #saves number to locals hash
end

def change_color(string)
  if string == 'Way too high!' || string == 'Way too low!'
    return 'background: red;'
  elsif string == 'Too high!' || string == 'Too low!'
    return 'background: #ff5050;'
  elsif string[0..6] == 'You got'
    return 'background: green'
  end
end

def check_guess(guess, number)
  if guess > number
    if guess > (number + 5)
      return 'Way too high!'
    else
      return 'Too high!'
    end
  elsif guess < number
    if guess < (number - 5)
      return 'Way too low!'
    else
      return 'Too low!'
    end
  else
    return "You got it right! The SECRET NUMBER is #{number}"
  end
end
