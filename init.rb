# gems
require 'sinatra'
require 'slim'
require 'active_record'

# files
require File.expand_path('config/database')
%w(models scripts).each do |dir|
  Dir["#{File.dirname(__FILE__)}/#{dir}/*.rb"].each { |f| require f }
end
