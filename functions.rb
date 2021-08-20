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
    class_guess = params[:class_name].upcase
    student_ids_string = []
    db = connect_to_db()
    students = db.execute("SELECT id FROM student WHERE grade = ?", [class_guess])

    if !students.any?
        flash[:error] = "This class does not exist. Try another class!"
        redirect back
    else 
        students.each do |student|
            student_ids_string << student['id'] 
        end
        @current_student_id = student_ids_string.sample
        @student_ids_string = student_ids_string.join(",")
        @student = db.execute("SELECT * FROM student WHERE id = ?", [@current_student_id])
        erb :guess
    end
end
post '/guess/:klass_string/:id' do
    @klass_string = params[:klass_string]
    @current_student_id = params[:id]
    @firstname_guess = params[:firstname].capitalize
    @lastname_guess = params[:lastname].capitalize

    db = connect_to_db()

    @correct_student = db.execute("SELECT * FROM student WHERE id = ?", [@current_student_id])
    
    if @correct_student[0]['firstname'] == @firstname_guess && @correct_student[0]['lastname'] == @lastname_guess
        @klass_string = @klass_string.split(',')
        p @klass_string
        if @klass_string.include?(@current_student_id)
            @klass_string.delete_at(@current_student_id.to_i-1)
            @current_student_id = @klass_string.sample
            @student_ids_string = @klass_string.join(",")
            p @student_ids_string

        end 
        p @current_student_id
        erb :correct
    else
        erb :wrong
    end
end


post '/next_student/:klass_string' do
    @klass_string = params[:klass_string]
    student_id_array = @klass_string.split(',')
    db = connect_to_db()
    student_id = student_id_array.first

    student = db.execute("SELECT * FROM student WHERE id = ?", [student_id])
    students = db.execute("SELECT * FROM student WHERE grade = ?", [student[0]['grade']])
    if !student.any?
        erb :finish
    else
        p students
        @student = students.sample
        p @students
        p @student[0][3]
        erb :guess
    end
end


































# def connect_to_db()
#     db = SQLite3::Database.new('DB/database.db')
#     db.results_as_hash = true 
#     return db 
# end 

# get '/' do 
#     erb :start
# end

# post '/' do
#     grade_search = params[:class_name] 
#     db = connect_to_db()
#     students = db.execute("SELECT * FROM student WHERE grade = ?", [grade_search])

#     if !students.any?
#         flash[:error] = "This class does not exist. Try another class!"
#         redirect back
#     else 
#         @student = students.first
#         erb :guess
#     end
# end

get '/wrong' do 
    erb :wrong
end 


get '/start' do 
    erb :start
end 

get '/guess' do
    erb :guess
end

# post '/quess/:id' do
#     #hämta student från db
#     #jämför med vad som finns i params

#     #om rätt
#     #hämta ny student från db

# end

get '/finish' do
    erb :finish
end
get '/correct' do
    erb :correct
end

