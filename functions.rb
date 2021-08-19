require "sinatra"
require_relative "seed.rb"
#Fetches the class from database
#and saves them in an array
get '/' do 
    erb :start
end

post '/' do
    grade_search = params[:class_name] 
    db = connect_to_db()
    grade = db.execute("SELECT * FROM student WHERE grade = ?", [grade_search])

    if grade == nil
        "hello"
    else 
        erb :guess
    end
end