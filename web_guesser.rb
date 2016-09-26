require 'sinatra'
require 'sinatra/reloader'

random_n = rand(101)
get '/' do
  "The SECRET NUMBER is #{random_n}"
end
