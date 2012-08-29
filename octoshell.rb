require File.expand_path('init')

class Octoshell < Sinatra::Base
  get '/' do
    redirect '/example'
  end
  
  get '/example' do
    example = Example.new
    example.run
    @result = example.result
    slim :example
  end
end
