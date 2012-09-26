require File.expand_path('init')

class Octoshell < Sinatra::Base
  JS_ESCAPE_MAP = { '\\' => '\\\\', '</' => '<\/', "\r\n" => '\n', "\n" => '\n', "\r" => '\n', '"' => '\\"', "'" => "\\'" }
  
  set :views, settings.root + '/app/views'
  use Rack::Session::Cookie, 
        key: "_mgu_session",
        secret: "3d3bc09c12b68b78f694a99d6d915c176e17497e81cee098312b1e483914df203b9d537606d5cea6df5f63eaa44fd36aad9ab1b0b6209da42f8e2821e580dbf0"
  
  helpers do
    def escape_javascript(javascript)
      if javascript
        javascript.gsub(/(\\|<\/|\r\n|[\n\r"'])/) { JS_ESCAPE_MAP[$1] }
      else
        ''
      end
    end
  end
  
  get '/run/' do
    redirect '/run/example'
  end
  
  get '/run/log' do
    @logstack = []
    begin
      File::Tail::Logfile.open("log/application.log", break_if_eof: true) do |log|
        log.interval = 1000
        log.backward(1000).tail do |log|
          @logstack << log
        end
      end
    rescue File::Tail::BreakException
    end
    slim :log
  end
  
  get '/run/:name' do |name|
    render = proc do
      @script = name.camelize.constantize.new
      @script.run
      content_type 'text/plain'
      slim name.to_sym
    end
    
    if production?
      user = User.find_by_id(session[:user_id])
      if user && user.admin
        render.call
      else
        status 401
        slim "h1 Not Authorized"
      end
    else
      render.call
    end
  end
  
  def production?
    ENV['OCTOSHELL_ENV'] != 'development'
  end
end
