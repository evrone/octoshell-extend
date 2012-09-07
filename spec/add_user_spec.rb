require File.expand_path('init')

describe AddUser do
  before do
    p = AddProject.new(Task.new)
    p.stub(:host) { 'hostname' }
    p.stub(:project_login) { 'project_1' }
    p.perform
  end

  subject do
    proc = AddUser.new(Task.new)
    proc.stub(:host) { 'hostname' }
    proc.stub(:project_login) { 'project_1' }
    proc.stub(:user_login) { 'user_1' }
    proc.stub(:additional_attributes) { { attribute: 'value' } }
    proc
  end

  its(:perform) { should be_true }
end

