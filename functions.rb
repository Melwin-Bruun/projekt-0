require "sinatra"
require_relative "DB/seed.rb"
#Fetches the class from database
#and saves them in an array
get '/' do 
    erb :start
end

post('/start') do
    grade_search = params[:class_name] 
    grade = db.execute("SELECT * FROM students WHERE grade = ?", [grade_search])
    if grade_search == grade 
        redirect '/guess'
    else 
       hej
    end
end