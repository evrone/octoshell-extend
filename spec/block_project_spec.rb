require File.expand_path('init')

describe BlockProject do
  before do
    p = AddProject.new(Task.new)
    p.stub(:host) { 'hostname' }
    p.stub(:project_login) { 'project_1' }
    p.perform

    p = AddUser.new(Task.new)
    p.stub(:host) { 'hostname' }
    p.stub(:project_login) { 'project_1' }
    p.stub(:user_login) { 'user_1' }

    p.perform
  end

  subject do
    proc = BlockProject.new(Task.new)
    proc.stub(:host) { 'hostname' }
    proc.stub(:project_login) { 'project_1' }
    proc.stub(:cluster_user_logins) { ['user_1'] }
    proc.stub(:additional_attributes) { { attribute: 'value' } }
    proc
  end

  its(:perform) { should be_true }
end

