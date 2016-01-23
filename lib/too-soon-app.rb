require 'rubygems'
require 'bundler/setup'

require 'sinatra'
# twitter
require_relative "./too-soon/db"

get '/' do
  'Hello world!'
end
