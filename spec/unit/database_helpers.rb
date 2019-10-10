require 'pg'
require './database_connection_setup'

def persisted_data(id:, table:)
  DatabaseConnection.query("SELECT * FROM #{table} WHERE id = #{id};")
end
