require 'sinatra'
require 'sinatra/reloader' #reloads server immediately after change in rb

number = rand(101)
get '/' do
  guess = params['guess'].to_i 
  message = check_guess(guess, number)
  erb :index, :locals => {:number => number, :message => message} #saves number to locals hash
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
      return 'Too Low!'
    end
  else
    return "You got it right! The SECRET NUMBER is #{number}"
  end
end
