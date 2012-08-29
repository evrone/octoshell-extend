connections = YAML.load_file("config/database.yml")
ActiveRecord::Base.establish_connection(connections['readonly'])
