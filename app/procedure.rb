class Procedure
  attr_reader :task, :comment
  
  def initialize(task)
    @task = task
    @comment = ""
  end
  
  def perform
    raise "Implement Me!"
  end
end
