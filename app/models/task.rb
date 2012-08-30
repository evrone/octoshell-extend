class Task < ActiveRecord::Base
  belongs_to :resource, polymorphic: true
  belongs_to :task
  has_many :tasks
  
  def perform
    procedure = self.procedure.camelize.constantize.new(self)
    self.success = procedure.perform
    self.comment = procedure.comment
    save!
    Resque.enqueue(TasksCallbacksWorker, id)
  rescue => e
    self.success = false
    self.comment = e.to_s
    save!
  end
end
