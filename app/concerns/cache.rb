module Cache
  extend ActiveSupport::Concern
  
  included do
    class_variable_set :@@cache, {}
    unless class_variables.include? :@@cache_time
      class_variable_set :@@cache_time, 5.minutes
    end
  end
  
  def cache
    c = self.class.class_variable_get :@@cache
    t = self.class.class_variable_get :@@cache_time
    if c[:data] && (Time.current < (c[:time] + t))
      c[:data]
    end
  end
  
  def cache=(result)
    self.class.class_variable_set :@@cache, { time: Time.current, data: result }
    result
  end
end