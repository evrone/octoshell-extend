require File.expand_path('../init', __FILE__)

threads = Cluster.all.map do |cluster|
  Thread.new do
    Thread.current[:cluster] = cluster
    loop do
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
        request.log = request.log.to_s + "#{Time.now} #{e.message}"
        request.save!
        sleep 5
      end
    end
  end
end

threads.each &:join
