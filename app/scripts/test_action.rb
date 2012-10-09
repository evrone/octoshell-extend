class TestAction
  attr_reader :result

  def run(params)
    # get result
    @result = File.read "/tmp/test1.txt"
  end
end
