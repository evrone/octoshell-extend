class Cluster < ActiveRecord::Base
  class Log < ActiveRecord::Base
    belongs_to :cluster
  end
  
  has_many :tickets
  has_many :cluster_fields
  has_many :cluster_projects
  has_many :logs
  
  def log(msg)
    logs.create! "#{Time.now} #{msg}"
  end
end
