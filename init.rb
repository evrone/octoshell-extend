require 'bundler'
Bundler.setup

# gems
require 'sinatra'
require 'slim'
require 'active_record'
require 'active_support'
require 'resque'

# files
require File.expand_path('config/database')
require File.expand_path('app/procedure')

%w(models scripts procedures workers).each do |dir|
  Dir["#{File.dirname(__FILE__)}/app/#{dir}/*.rb"].each { |f| require f }
end

SSH_KEY_PATH = File.expand_path('config/keys/private')
