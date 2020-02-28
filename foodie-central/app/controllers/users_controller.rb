class UsersController < ApplicationController
    
    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        user = User.create(params)
        if user.save
            session[:user_id] = user.id
            redirect '/recipes'
        elsif
            params[:username].empty? || params[:email].empty? || params[:password].empty?
            flash.now[:error] = "All fields are required to sign up. Please try again."
            erb :'users/signup'
        end
    end

    get '/login' do
        erb :'users/login'
    end


    # use authenticate on the params password field
    post '/login' do
        user = User.find_by(username: params[:username], email: params[:email], password_digest: params[:password])
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
            flash.now[:error] = "Username, Email, and Password must be filled out."
            erb :'users/login'
        elsif 
            user && user.authenticate(params[:password])
                session[:user_id] = user.id
                redirect '/recipes'
        else
            flash.next[:error] = "Cannot find account."
            redirect '/login'
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

end