# Octoshell Schema

~~~ruby
ActiveRecord::Schema.define(:version => 20120829094834) do

  create_table "accesses", :force => true do |t|
    t.integer  "credential_id"
    t.string   "state"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "cluster_user_id"
  end

  add_index "accesses", ["credential_id"], :name => "index_accesses_on_credential_id"
  add_index "accesses", ["state"], :name => "index_accesses_on_state"

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "state"
    t.string   "username"
  end

  add_index "accounts", ["project_id"], :name => "index_accounts_on_project_id"
  add_index "accounts", ["state"], :name => "index_accounts_on_state"
  add_index "accounts", ["user_id", "project_id"], :name => "index_accounts_on_user_id_and_project_id", :unique => true
  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "cluster_fields", :force => true do |t|
    t.integer "cluster_id"
    t.string  "name"
  end

  add_index "cluster_fields", ["cluster_id"], :name => "index_cluster_fields_on_cluster_id"

  create_table "cluster_users", :force => true do |t|
    t.integer  "project_id"
    t.string   "state"
    t.integer  "cluster_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "request_id"
  end

  add_index "cluster_users", ["cluster_id"], :name => "index_cluster_users_on_cluster_id"
  add_index "cluster_users", ["project_id"], :name => "index_cluster_users_on_project_id"
  add_index "cluster_users", ["request_id"], :name => "index_cluster_users_on_request_id"

  create_table "clusters", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                                                                                               :null => false
    t.datetime "updated_at",                                                                                               :null => false
    t.string   "host"
    t.string   "description"
    t.string   "state"
    t.text     "add_user",             :default => "project=%project%\nhost=%host%"
    t.text     "del_user",             :default => "project=%project%\nhost=%host%"
    t.text     "add_openkey",          :default => "project=%project%\nuser=%user%\nhost=%host%\npublic_key=%public_key%"
    t.text     "del_openkey",          :default => "project=%project%\nuser=%user%\nhost=%host%\npublic_key=%public_key%"
    t.text     "block_user",           :default => "project=%project%\nhost=%host%"
    t.text     "unblock_user",         :default => "project=%project%\nhost=%host%"
    t.text     "statistic"
    t.text     "get_statistic",        :default => "host=%host%"
    t.datetime "statistic_updated_at"
    t.string   "cluster_user_type",    :default => "account"
  end

  add_index "clusters", ["state"], :name => "index_clusters_on_state"

  create_table "credentials", :force => true do |t|
    t.text     "public_key"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.string   "state"
  end

  add_index "credentials", ["public_key", "user_id"], :name => "index_credentials_on_public_key_and_user_id", :unique => true
  add_index "credentials", ["public_key"], :name => "index_credentials_on_public_key"
  add_index "credentials", ["user_id", "state"], :name => "index_credentials_on_user_id_and_state"
  add_index "credentials", ["user_id"], :name => "index_credentials_on_user_id"

  create_table "fields", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "model_type"
    t.integer  "position",   :default => 1
    t.datetime "deleted_at"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "state"
  end

  add_index "memberships", ["organization_id"], :name => "index_memberships_on_organization_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "organization_kinds", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "state"
  end

  add_index "organization_kinds", ["state"], :name => "index_organization_kinds_on_state"

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.boolean  "approved",             :default => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "state"
    t.string   "abbreviation"
    t.integer  "organization_kind_id"
  end

  add_index "organizations", ["state"], :name => "index_organizations_on_state"

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pages", ["url"], :name => "index_pages_on_url", :unique => true

  create_table "position_names", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "positions", :force => true do |t|
    t.integer  "membership_id"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "positions", ["membership_id"], :name => "index_positions_on_membership_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "user_id"
    t.string   "state"
    t.text     "description"
    t.integer  "organization_id"
    t.string   "cluster_user_type", :default => "account"
    t.string   "username"
  end

  add_index "projects", ["organization_id"], :name => "index_projects_on_organization_id"
  add_index "projects", ["state"], :name => "index_projects_on_state"
  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "replies", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ticket_id"
    t.text     "message"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  add_index "replies", ["ticket_id"], :name => "index_replies_on_ticket_id"
  add_index "replies", ["user_id"], :name => "index_replies_on_user_id"

  create_table "request_properties", :force => true do |t|
    t.string  "name"
    t.string  "value"
    t.integer "request_id"
  end

  add_index "request_properties", ["request_id"], :name => "index_request_properties_on_request_id"

  create_table "requests", :force => true do |t|
    t.integer  "project_id"
    t.integer  "cluster_id"
    t.integer  "hours"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.string   "state"
    t.integer  "size"
    t.string   "comment"
  end

  add_index "requests", ["cluster_id"], :name => "index_requests_on_cluster_id"
  add_index "requests", ["project_id"], :name => "index_requests_on_project_id"
  add_index "requests", ["state"], :name => "index_requests_on_state"
  add_index "requests", ["user_id"], :name => "index_requests_on_user_id"

  create_table "sureties", :force => true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.string   "state"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "comment"
  end

  add_index "sureties", ["organization_id"], :name => "index_sureties_on_organization_id"
  add_index "sureties", ["state"], :name => "index_sureties_on_state"
  add_index "sureties", ["user_id"], :name => "index_sureties_on_user_id"

  create_table "tasks", :force => true do |t|
    t.text     "command"
    t.text     "stderr"
    t.text     "stdout"
    t.string   "state"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "procedure"
    t.text     "data"
    t.string   "event"
    t.string   "comment"
    t.boolean  "callbacks_performed", :default => false
    t.integer  "task_id"
  end

  add_index "tasks", ["resource_id", "resource_type"], :name => "index_tasks_on_resource_id_and_resource_type"
  add_index "tasks", ["state"], :name => "index_tasks_on_state"
  add_index "tasks", ["task_id"], :name => "index_tasks_on_task_id"

  create_table "ticket_field_relations", :force => true do |t|
    t.integer  "ticket_question_id"
    t.integer  "ticket_field_id"
    t.boolean  "required",           :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "use",                :default => false
  end

  add_index "ticket_field_relations", ["ticket_field_id"], :name => "index_ticket_field_relations_on_ticket_field_id"
  add_index "ticket_field_relations", ["ticket_question_id"], :name => "index_ticket_field_relations_on_ticket_question_id"

  create_table "ticket_field_values", :force => true do |t|
    t.string   "value"
    t.integer  "ticket_field_relation_id"
    t.integer  "ticket_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "ticket_field_values", ["ticket_field_relation_id"], :name => "index_ticket_field_values_on_ticket_field_relation_id"
  add_index "ticket_field_values", ["ticket_id"], :name => "index_ticket_field_values_on_ticket_id"

  create_table "ticket_fields", :force => true do |t|
    t.string   "name"
    t.string   "hint"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "state"
  end

  add_index "ticket_fields", ["state"], :name => "index_ticket_fields_on_state"

  create_table "ticket_questions", :force => true do |t|
    t.integer  "ticket_question_id"
    t.string   "question"
    t.boolean  "leaf",               :default => true
    t.string   "state"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "ticket_questions", ["state"], :name => "index_ticket_questions_on_state"
  add_index "ticket_questions", ["ticket_question_id"], :name => "index_ticket_questions_on_ticket_question_id"

  create_table "ticket_tag_relations", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "ticket_tag_id"
    t.boolean  "active",        :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "ticket_tag_relations", ["ticket_id"], :name => "index_ticket_tag_relations_on_ticket_id"
  add_index "ticket_tag_relations", ["ticket_tag_id"], :name => "index_ticket_tag_relations_on_ticket_tag_id"

  create_table "ticket_tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "state"
  end

  add_index "ticket_tags", ["state"], :name => "index_ticket_tags_on_state"

  create_table "ticket_templates", :force => true do |t|
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "state"
  end

  add_index "ticket_templates", ["state"], :name => "index_ticket_templates_on_state"

  create_table "tickets", :force => true do |t|
    t.string   "subject"
    t.text     "message"
    t.integer  "user_id"
    t.string   "state"
    t.string   "url"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "ticket_question_id"
    t.integer  "project_id"
    t.integer  "cluster_id"
  end

  add_index "tickets", ["cluster_id"], :name => "index_tickets_on_cluster_id"
  add_index "tickets", ["project_id"], :name => "index_tickets_on_project_id"
  add_index "tickets", ["state"], :name => "index_tickets_on_state"
  add_index "tickets", ["user_id"], :name => "index_tickets_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.datetime "deleted_at"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.boolean  "admin",                           :default => false
    t.string   "state"
    t.string   "token"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["activation_token"], :name => "index_users_on_activation_token"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"
  add_index "users", ["state"], :name => "index_users_on_state"
  add_index "users", ["token"], :name => "index_users_on_token", :unique => true

  create_table "values", :force => true do |t|
    t.integer  "field_id"
    t.integer  "model_id"
    t.integer  "model_type"
    t.text     "value"
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "values", ["field_id", "model_id", "model_type"], :name => "index_values_on_field_id_and_model_id_and_model_type", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "wiki_urls", :force => true do |t|
    t.integer "page_id"
    t.string  "url"
  end

  add_index "wiki_urls", ["page_id"], :name => "index_wiki_urls_on_page_id"
  add_index "wiki_urls", ["url"], :name => "index_wiki_urls_on_url"

end
~~~