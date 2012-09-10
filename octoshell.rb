require File.expand_path('init')

class Octoshell < Sinatra::Base
  set :views, settings.root + '/app/views'
  use Rack::Session::Cookie, 
        key: "_msu_session",
        secret: "3d3bc09c12b68b78f694a99d6d915c176e17497e81cee098312b1e483914df203b9d537606d5cea6df5f63eaa44fd36aad9ab1b0b6209da42f8e2821e580dbf0"
  
  get '/run/' do
    redirect '/run/example'
  end
  
  get '/run/:name' do |name|
    @script = name.camelize.constantize.new
    @script.run
    slim name.to_sym
  end
end
