require 'sqlite3'

def connect_to_db()
    db = SQLite3::Database.new('database.db')
    db.results_as_hash = true 
    return db 
end 

db = connect_to_db()

db.execute("DROP TABLE if exists 'student'")
db.execute("CREATE TABLE 'student' (
	'id'	INTEGER NOT NULL UNIQUE,
	'firstname'	TEXT NOT NULL,
	'lastname'	TEXT NOT NULL,
	'picture'	TEXT UNIQUE,
	'funfact'	TEXT,
	'grade'	TEXT,
	PRIMARY KEY('id' AUTOINCREMENT))"
)

db.execute("INSERT INTO STUDENT ('firstname', 'lastname') VALUES('senap', 'ketchup')")