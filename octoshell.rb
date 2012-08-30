require File.expand_path('init')

class Octoshell < Sinatra::Base
  set :views, settings.root + '/app/views'
  
  get '/' do
    redirect '/example'
  end
  
  get '/:name' do |name|
    @script = name.camelize.constantize.new
    @script.run
    slim name.to_sym
  end
end
