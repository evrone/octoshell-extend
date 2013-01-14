class AddUser < UserProcedure
  def perform

    attrs='';#additional_attributes.map {|o| o.to_s}.join('; ')
    @comment="Add user: #{user_login} #{project_login} on #{host} with #{attrs}\n"

#    @comment += `ssh -i #{SSH_KEY_PATH} octo@#{host} ./octo_add_user #{project_login}`
    @comment += `ssh -t -i #{SSH_KEY_PATH} octo@#{host}  sudo /usr/octo/add_user #{user_login} #{project_login}`

#    warn @comment
    $?.exitstatus == 0
  end
end
