require 'pg'
class DatabaseConnection
  def self.setup(db_name)
    PG.connect(dbname: db_name)
  end
end
