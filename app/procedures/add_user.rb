class AddUser < UserProcedure

  KEY_PATH='/home/serg/Work/Octoshell/octoshell-extend/'
  def perform

    attrs='';#additional_attributes.map {|o| o.to_s}.join('; ')
    @comment="Add user: #{user_login} #{project_login} on #{host} with #{attrs}\n"

#    @comment += `ssh -i #{KEY_PATH}/key octo@#{host} ./octo_add_user #{project_login}`
    @comment += `ssh -i #{KEY_PATH}/key octo@#{host}  sudo /usr/octo/add_user #{user_login} #{project_login}`

#    warn @comment
    $?.exitstatus == 0
  end
end
