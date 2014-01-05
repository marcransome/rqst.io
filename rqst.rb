require 'sinatra'

get '/' do
    "#{request.ip}"
end
