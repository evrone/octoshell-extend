require File.expand_path('init')

describe AddProject do
  subject do
    proc = AddProject.new(Task.new)
    proc.stub(:host) { 'hostname' }
    proc.stub(:project_login) { 'project_1' }
    proc.stub(:additional_attributes) { { attribute: 'value' } }
    proc
  end
  
  its(:perform) { should be_true }
end

