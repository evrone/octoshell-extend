require 'init'

class Octoshell < Sinatra::Base
  get '/' do
    @user = User.first
    slim :example
  end
end
