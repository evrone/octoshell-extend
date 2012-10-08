class ClusterStatistic
  attr_reader :result, :error
  
  def run
    @csv = format_stats(get_stats)
  rescue Cocaine::ExitStatusError => e
    @error = e.message
  end
  
  def top_by_size
    @csv.sort_by do |row|
      row[:size]
    end.reverse
  end
  
  def top_by_files
    @csv.sort_by do |row|
      row[:files]
    end.reverse
  end
  
private
  
  def get_stats
    if ENV['OCTOSHELL_ENV'] == 'development'
      dest_path = File.expand_path("../../../spec/data/du_last.csv", __FILE__)
      CSV.read(dest_path, col_sep: ':')
    else
      dest_path = '/tmp/du_last'
      cmd = Cocaine::CommandLine.new('scp', "-i #{SSH_KEY_PATH} octo@t60.parallel.ru:/root/du_last #{dest_path}")
      cmd.run
      csv = CSV.read(dest_path, col_sep: ':')
      File.unlink(dest_path)
      csv
    end
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