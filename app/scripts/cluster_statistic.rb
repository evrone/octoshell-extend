class ClusterStatistic
  attr_reader :result, :error
  
  def run
    @result = format_stats(get_stats)
  rescue Cocaine::ExitStatusError => e
    @error = e.message
  end
  
private
  
  def get_stats
    dest_path = '/tmp/du_last'
    
    cmd = Cocaine::CommandLine.new('scp', "-i #{SSH_KEY_PATH} octo@t60.parallel.ru:/root/du_last #{dest_path}")
    cmd.run
    csv = CSV.read(dest_path, col_sel: ':')
    File.unlink(dest_path)
    csv
  end
  
  def format_stats(csv)
    # example: ["D", "/home/00_arch", "files=14972", "kbytes=295253400"]
    csv.map do |row|
      { username: row[1][%r{/home/(.*)}, 1],
        files:    row[2][%r{files=(.*)}, 1].to_i,
        size:     row[3][%r{kbytes=(.*)}, 1].to_i.kilobytes }
    end
  end
end
