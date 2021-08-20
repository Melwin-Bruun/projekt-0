require "sinatra"
require "sinatra/flash"
require 'sqlite3'
#require_relative "seed.rb"
#Fetches the class from database
#and saves them in an array
enable :sessions

def connect_to_db()
    db = SQLite3::Database.new('DB/database.db')
    db.results_as_hash = true 
    return db 
end 

get '/' do 
    erb :start
end

post '/' do
    grade_search = params[:class_name] 
    db = connect_to_db()
    students = db.execute("SELECT * FROM student WHERE grade = ?", [grade_search])

    if !students.any?
        flash[:error] = "This class does not exist. Try another class!"
        redirect back
    else 
        @student = students.first
        erb :guess
    end
end

get '/wrong' do 
    erb :wrong
end 


get '/start' do 
    erb :start
end 

get '/guess/' do
    erb :guess
end

post '/quess/:id' do
    #hämta student från db
    #jämför med vad som finns i params

    #om rätt
    #hämta ny student från db

end

get '/finish' do
    erb :finish
end
get '/correct' do
    erb :correct
end

