class DelUser < UserProcedure
  def perform
    attrs=additional_attributes.map {|o| o.to_s}.join('; ')
    @comment="Del user: #{project_login} on #{host} with #{attrs}\n"

#    @comment += `ssh -i #{SSH_KEY_PATH} octo@#{host} ./octo_add_user #{project_login}`
    @comment += `ssh -i #{SSH_KEY_PATH} octo@#{host} sudo /usr/octo/del_user #{user_login}`

    $?.exitstatus == 0
  end
end
