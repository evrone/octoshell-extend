require File.expand_path('../init', __FILE__)

$failed = false
$error = ""
threads = Cluster.all.map do |cluster|
  Thread.new do
    loop do
      $failed && break
      
      begin
        if request = Request.where(cluster_id: cluster.id).for_maintain
          m = Maintainer.new(request)
          m.maintain!
          Request.where(id: request.id).where(
            "maintain_requested_at <= ?",  request.maintain_requested_at + 1
          ).update_all(maintain_requested_at: nil)
        end
        sleep 1
      rescue Server::Fail => e
        $failed = true
        $error = e.message
        Thread.current.exit
      end
    end
  end
end

threads.each &:join
puts $error
