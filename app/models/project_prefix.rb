class ProjectPrefix < ActiveRecord::Base
  has_many :projects
  
  def to_s
    name
  end
end
