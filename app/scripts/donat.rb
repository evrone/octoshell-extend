class Donat
  attr_reader :result
  
  def run
    @result = Cluster.all.map do |cluster|
      { label: cluster.name, value: rand(40) }
    end
  end
end
