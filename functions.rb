require "sinatra"
require "sinatra/flash"
require_relative "seed.rb"
#Fetches the class from database
#and saves them in an array
enable :sessions
get '/' do 
    p flash
    erb :start
end

post '/' do
    grade_search = params[:class_name] 
    db = connect_to_db()
    grade = db.execute("SELECT * FROM student WHERE grade = ?", [grade_search])

    if grade.empty?
        flash[:error] = "This class does not exist. Try another class!"
        redirect back
    else 
        erb :guess
    end
end



get '/wrong' do
    erb :wrong
end
get '/start' do
    erb :start
end
get '/guess' do
    erb :guess
end
get '/finish' do
    erb :finish
end
get '/correct' do
    erb :correct
end