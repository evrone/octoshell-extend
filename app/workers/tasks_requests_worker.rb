class TasksRequestsWorker
  @queue = :task_requests
  
  def perform(task_id)
    Task.find(task_id).perform
  end
end
