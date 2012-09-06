class TestAction
  attr_reader :result

  def run
    # get result
    @result = File.read "/tmp/test1.txt"
  end
end
