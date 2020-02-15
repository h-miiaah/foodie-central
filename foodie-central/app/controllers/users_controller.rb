class UsersController < ApplicationController
    
    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        user = User.create(params)
        if user.username.empty? || user.email.empty? || user.password_digest.empty?
            @error = "Username, Email, and Password must be filled out."
            erb :'users/signup'
        elsif
            User.find_by(username: user.username)
            @error = "Username taken, please use a different username."
            erb :'users/signup'
        else
            user.save
            session[:user_id] = user.id
            redirect '/recipes'
        end
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
        if params[:username].empty? || params[:email].empty? || params[:password_digest].empty?
            @error = "Username, Email, and Password must be filled out."
            erb :'users/login'
        elsif 
            user = User.find_by(username: params[:username], email: params[:email], password_digest: params[:password_digest])
                session[:user_id] = user.id
                redirect '/recipes'
        else
            @error = "Cannot find account."
            redirect '/login'
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

end