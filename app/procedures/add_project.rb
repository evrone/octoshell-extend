class AddProject < ProjectProcedure
#  def host
#  def project_login
#  def additional_attributes
  def perform

    attrs='';#additional_attributes.map {|o| o.to_s}.join('; ')
    @comment="Add group: #{project_login} on #{host} with #{attrs}\n"

#    @comment += `ssh -i #{SSH_KEY_PATH} octo@#{host} ./octo_add_user #{project_login}`
#    puts "ssh -i #{SSH_KEY_PATH} octo@localhost sudo /usr/octo/add_group #{project_login}"
    @comment += `ssh -t -i #{SSH_KEY_PATH} octo@#{host} sudo /usr/octo/add_group #{project_login}`

#    warn @comment
    $?.exitstatus == 0

  end
end
