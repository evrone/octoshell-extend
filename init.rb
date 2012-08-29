# gems
require 'sinatra'
require 'slim'
require 'active_record'

# files
require File.expand_path('config/database')
Dir[File.dirname(__FILE__)+"/models/*.rb"].each { |file| require file }
