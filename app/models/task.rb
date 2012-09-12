class Task < ActiveRecord::Base
  belongs_to :resource, polymorphic: true
  belongs_to :task
  has_many :tasks
  
  def perform
    if ENV['OCTOSHELL_EXTEND_TEST']
      update_attribute(:state, 'successed')
    else
      procedure = self.procedure.camelize.constantize.new(self)
      self.state = procedure.perform ? 'successed' : 'failed'
      self.comment = procedure.comment
      save!
    end
    Resque.enqueue(TasksCallbacksWorker, id) if state == 'successed'
  rescue => e
    self.state = 'failed'
    error = ""
    error << e.to_s
    error << e.backtrace.join("\n")
    self.comment = error
    save!
  end
end
