#
#  rqst.rb
#
#  Copyright (c) 2014 Marc Ransome <marc.ransome@fidgetbox.co.uk>
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to
#  deal in the Software without restriction, including without limitation the
#  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
#  sell copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
#  DEALINGS IN THE SOFTWARE.
#

require 'sinatra'
require 'json'

configure :production do
  require 'newrelic_rpm'
end

helpers do
  def dont_cache
    expires Time.at(0), :no_store, :no_cache, :must_revalidate
  end
end

get '/' do
  send_file(File.join(settings.public_folder, 'index.html'))
end

post '/params' do
  dont_cache
  content_type 'application/json'
  JSON.pretty_generate(params)
end

get '/ip' do
  dont_cache
  content_type 'application/json'
  JSON.pretty_generate({ "ip" => "#{request.ip}"})
end

not_found do
  send_file(File.join(settings.public_folder, '404.html'), {:status => 404})
end

get '/sitemap.xml' do
  send_file(File.join(settings.public_folder, 'sitemap.xml'))
end

