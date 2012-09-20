class Chart
  attr_reader :result
  
  def run
    @result = []
    (1..10).reverse_each do |i|
      @result << { time: (Time.now - i.minutes), usage: 10 + rand(90) }
    end
  end
end
