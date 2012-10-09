class ClusterStatistic
  include Cache
  
  attr_reader :result, :error
  
  def run(params)
    @csv = begin
      self.cache ||= format_stats(get_stats)
    end
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
    cluster_users = ClusterUser.where(cluster_project_id: ClusterProject.where(cluster_id: 4).pluck(:id)).to_a
    csv.map do |row|
      username = row[1][%r{/home/(.*)}, 1]
      { cluster_user: cluster_users.find { |cu| cu.username == username },
        username:     username,
        files:        row[2][%r{files=(.*)}, 1].to_i,
        size:         row[3][%r{kbytes=(.*)}, 1].to_i.kilobytes }
    end
  end
end
