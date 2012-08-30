class Procedure
  attr_reader :task
  
  def initialize(task)
    @task = task
  end
  
  def perform
    raise "Implement Me!"
  end
end
