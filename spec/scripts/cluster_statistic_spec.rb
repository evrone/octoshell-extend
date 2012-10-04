require File.expand_path('init')

describe ClusterStatistic do
  let(:cluster_statistic) do
    cs = ClusterStatistic.new
    cs.stub(:get_stats) { [["D", "/home/00_arch", "files=14972", "kbytes=295253400"]] }
    cs
  end
  
  describe '#result' do
    before { cluster_statistic.run }
    subject { cluster_statistic.result }
    
    it do
      should == [{ username: '00_arch', files: 14972, size: 295253400.kilobytes }]
    end
  end  
end
