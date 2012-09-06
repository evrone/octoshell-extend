class TestProc < Procedure
  def perform
    # executed code here
    File.open "/tmp/test1.txt", "a" do |f|
      f.puts "test!"
    end
  end
end
