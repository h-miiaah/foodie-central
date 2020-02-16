class RecipesController < ApplicationController
    
    get '/recipes/new' do
        if logged_in?
            erb :'/recipes/new'
        else
            redirect '/login'
        end
    end
    
    post '/recipes' do
        recipe = current_user.recipes.build(params)
        if !recipe.title.empty? && !recipe.instructions.empty? && !recipe.cook_time.empty?
            recipe.save
            redirect '/recipes'
        else
            @error = "All fields must be filled out. Please try again."
            erb :'/recipes/new' 
        end
    end

    get '/recipes' do
        if logged_in?
            @recipes = Recipe.all
            erb :'recipes/index'
        else
            redirect '/login'
        end
    end

    get '/recipes/:id' do
        if logged_in?
            @recipe = Recipe.find(params[:id])
            erb :'recipes/show'
        else
            redirect '/login'
        end
    end

    get '/recipes/:id/edit' do
        if logged_in?
            @recipe = Recipe.find(params[:id])
            erb :'recipes/edit'
        else
            redirect '/login'
        end
    end

    patch '/recipes/:id' do
        @recipe = Recipe.find(params[:id])
        if !params["recipe"]["title"].empty? && !params["recipe"]["instructions"].empty? && !params["recipe"]["cook_time"].empty?
        @recipe.update(params["recipe"])
        redirect "/recipes/#{@recipe.id}"
        else
            @error = "All fields must be filled out. Please try again."
            erb :'/recipes/edit' 
        end
    end

    delete '/recipes/:id' do
        recipe = Recipe.find(params[:id])
        recipe.destroy
        redirect '/recipes'
    end
    
end