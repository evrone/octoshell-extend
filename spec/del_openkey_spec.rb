require File.expand_path('init')

describe DelOpenkey do
  before do
    p = AddUser.new(Task.new)
    p.stub(:host) { 'hostname' }
    p.stub(:project_login) { 'project_1' }
    p.stub(:user_login) { 'user_1' }
    p.perform

    k = AddOpenkey.new(Task.new)
    k.stub(:host) { 'hostname' }
    k.stub(:project_login) { 'project_1' }
    k.stub(:user_login) { 'user_1' }
    k.stub(:public_key) { '=== trampampap' }
    k.perform
  end

  subject do
    proc = DelOpenkey.new(Task.new)
    proc.stub(:host) { 'hostname' }
    proc.stub(:project_login) { 'project_1' }
    proc.stub(:user_login) { 'user_1' }
    proc.stub(:public_key) { '=== trampampap' }
    proc.stub(:additional_attributes) { { attribute: 'value' } }
    proc
  end

  its(:perform) { should be_true }
end

