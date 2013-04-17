require File.expand_path('../init', __FILE__)

loop do
  if request = Request.for_maintain
    m = Maintainer.new(request)
    m.maintain!
  end
  
  sleep 5
end
