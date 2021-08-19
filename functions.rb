require "sinatra"
require_relative "seed.rb"
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