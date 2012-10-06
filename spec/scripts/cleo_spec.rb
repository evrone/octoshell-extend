require File.expand_path('init')

describe Cleo do
  let(:cleo) do
    cleo = Cleo.new
    cleo.stub(:raw_bigmem)  { File.read('spec/data/cleo-xml-status.bigmem.xml') }
    cleo.stub(:raw_hddmem)  { File.read('spec/data/cleo-xml-status.hddmem.xml') }
    cleo.stub(:raw_test)    { File.read('spec/data/cleo-xml-status.test.xml') }
    cleo.stub(:raw_hdd)     { File.read('spec/data/cleo-xml-status.hdd.xml') }
    cleo.stub(:raw_regular) { File.read('spec/data/cleo-xml-status.regular.xml') }
    cleo
  end
  
  describe '#result' do
    before { cleo.run }
    subject { cleo.result }
    
    it do
      subject[:summary][:nodes].should == {
        :free    => 208,
        :busy    => 4296,
        :blocked => 568
      }
      subject[:summary][:tasks].should == {
        :total   => 152,
        :queued  => 44,
        :blocked => 5
      }
    end
  end  
end
