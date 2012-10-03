require 'bundler'
Bundler.setup

# gems
require 'sinatra'
require 'slim'
require 'active_record'
require 'active_support'
require 'resque'
require 'logger'
require 'file-tail'

# files
require File.expand_path('config/database')
require File.expand_path('config/logger')
require File.expand_path('app/procedure')

require 'csv'
require 'active_support/core_ext/numeric/bytes.rb'

%w(models scripts procedures workers).each do |dir|
  Dir["#{File.dirname(__FILE__)}/app/#{dir}/*.rb"].each { |f| require f }
end

SSH_KEY_PATH = File.expand_path('config/keys/private')

Time.zone = 'Moscow'
