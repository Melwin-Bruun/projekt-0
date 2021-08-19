require 'sqlite3'

def connect_to_db()
    @db = SQLite3::Database.new('db/Database.db')
    @db.results_as_hash = true 
      return @db 

end 

db = connect_to_db()
db.execute("drop table if exist ´students´")