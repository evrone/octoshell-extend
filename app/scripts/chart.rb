class Chart
  attr_reader :result
  
  def run
    @result = []
    (1..10).reverse_each do |i|
      @result << { time: (Time.now - i.minutes), usage: 40 + i * 10 + rand(10) }
    end
  end
end
