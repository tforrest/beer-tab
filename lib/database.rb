require 'active_record'

# DatabaseConnector connects active record to the database
class DatabaseConnector
  class << self
    def connect
      ActiveRecord::Base.logger = Logger.new('app.log')
      config = YAML::safe_load(IO.read(database_config_sqlite3))
      ActiveRecord::Base.establish_connection(config)
    end

    def database_config_sqlite3
      'config/database_sqlite3.yml'
    end
  end
end