class Cleo
  attr_reader :result
  
  FILES = %w(bigmem hddmem test hdd regular)
  
  def run
    @result = get_result
  end
  
private

  def get_result
    result = result_template
    FILES.each do |file|
      result[:queues][file] = send(file)
      result[:summary][:nodes][:free]    += result[:queues][file][:nodes][:free]
      result[:summary][:nodes][:busy]    += result[:queues][file][:nodes][:busy]
      result[:summary][:nodes][:blocked] += result[:queues][file][:nodes][:blocked]
      result[:summary][:nodes][:total]   += result[:queues][file][:nodes][:total]
      result[:summary][:tasks][:total]   += result[:queues][file][:tasks][:total]
      result[:summary][:tasks][:queued]  += result[:queues][file][:tasks][:queued]
      result[:summary][:tasks][:blocked] += result[:queues][file][:tasks][:blocked]
      result[:summary][:tasks][:running] += result[:queues][file][:tasks][:running]
      result[:summary][:tasks][:prerun]  += result[:queues][file][:tasks][:prerun]
      result[:summary][:users].push         *result[:queues][file][:users]
      result[:summary][:organizations].push *result[:queues][file][:organizations]
    end
    
    result[:summary][:users].uniq!
    result[:summary][:organizations].uniq!
    result
  end
  
  def result_template
    {
      queues: {},
      summary: {
        nodes: {
          free: 0,
          busy: 0,
          blocked: 0,
          total: 0
        },
        tasks: {
          total: 0,
          queued: 0,
          blocked: 0,
          running: 0,
          prerun: 0
        },
        users: [],
        organizations: []
      }
    }
  end
  
  def get_raw(type)
    if ENV['OCTOSHELL_ENV'] == 'development'
      file = File.read(File.expand_path("../../../spec/data/cleo-xml-status.#{type}.xml", __FILE__))
    else
      dest_path = "/tmp/cleo-xml-status.#{type}"
      cmd = Cocaine::CommandLine.new('scp', "-i #{SSH_KEY_PATH} octo@t60.parallel.ru:#{dest_path} #{dest_path}")
      cmd.run
      file = File.read(dest_path)
      File.unlink(dest_path)
    end
    file
  end
  
  FILES.each do |file|
    define_method "raw_#{file}" do
      get_raw(file)
    end
    
    define_method file do
      res = { users: [], organizations: [] }
      h = Hash.from_xml(send "raw_#{file}")['cleo_state']
      res[:nodes] = {
        total:   h['cpus']['cpu_statistics']['total_number'].to_i,
        free:    h['cpus']['cpu_statistics']['total_free'].to_i,
        busy:    h['cpus']['cpu_statistics']['total_busy'].to_i,
        blocked: h['cpus']['cpu_statistics']['blocked_count'].to_i
      }
      res[:tasks] = {
        total:   h['tasks']['tasks_statistics']['tasks_total'].to_i,
        running: h['tasks']['tasks_statistics']['tasks_running'].to_i,
        prerun:  h['tasks']['tasks_statistics']['tasks_prerun'].to_i,
        queued:  h['tasks']['tasks_statistics']['tasks_queued'].to_i,
        blocked: h['tasks']['tasks_statistics']['tasks_blocked'].to_i,
        tasks:   []
      }
      
      if h['tasks']['task']
        h['tasks']['task'].each do |task|
          res[:users] << task['user']
          res[:tasks][:tasks] << {
            id:      task['id'],
            user:    task['user'],
            state:   task['state'],
            name:    task['sexe'],
            blocked: task['blocked'].to_i == 1
          }
        end 
      
        res[:organizations] = ClusterProject.where(username: res[:users]).
          includes(project: :organization).map { |cp| cp.project.organization }.uniq
      end
      res
    end
  end
end
