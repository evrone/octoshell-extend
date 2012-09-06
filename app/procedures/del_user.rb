class DelUser < UserProcedure

  KEY_PATH='/home/serg/Work/Octoshell/octoshell-extend/'
  def perform

    attrs=additional_attributes.map {|o| o.to_s}.join('; ')
    @comment="Del user: #{project_login} on #{host} with #{attrs}\n"

#    @comment += `ssh -i #{KEY_PATH}/key octo@#{host} ./octo_add_user #{project_login}`
    @comment += `ssh -i #{KEY_PATH}/key octo@localhost /usr/octo/del_user #{project_login}`

    $?.exitstatus == 0
  end
end
