require File.expand_path('../init', __FILE__)

loop do
  if request = Request.for_maintain
    m = Maintainer.new(request)
    m.maintain!
    Request.where(id: request.id).where(
      "maintain_requested_at <= ?",  request.maintain_requested_at + 1
    ).update_all(maintain_requested_at: nil)
  end
  
  sleep 5
end
