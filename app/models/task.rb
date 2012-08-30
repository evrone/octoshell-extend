class Task < ActiveRecord::Base
  belongs_to :resource, polymorphic: true
  belongs_to :task
  has_many :tasks
  
  def perform
    procedure = self.procedure.camelize.constantize.new(self)
    self.state = procedure.perform ? 'successed' : 'failed'
    self.comment = procedure.comment
    save!
    Resque.enqueue(TasksCallbacksWorker, id)
  rescue => e
    self.state = 'failed'
    error = ""
    error << e.to_s
    error << e.backtrace.join("\n")
    self.comment = error
    save!
  end
end
