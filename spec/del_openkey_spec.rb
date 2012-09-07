require File.expand_path('init')

describe DelOpenkey do
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

