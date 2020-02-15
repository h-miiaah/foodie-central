class RecipesController < ApplicationController
    
    get '/recipes/new' do
        erb :'/recipes/new'
    end
    
    post '/recipes' do
        recipe = Recipe.new(params)
        if !recipe.title.empty? && !recipe.instructions.empty? && !recipe.cook_time.empty?
            recipe.save
            redirect '/recipes'
        else
            @error = "All fields must be filled out. Please try again."
            erb :'/recipes/new' 
        end
    end

    get '/recipes' do
        @recipes = Recipe.all
        erb :'recipes/index'
    end

    get '/recipes/:id' do
        @recipe = Recipe.find(params[:id])
        erb :'recipes/show'
    end

    get '/recipes/:id/edit' do
        @recipe = Recipe.find(params[:id])
        erb :'recipes/edit'
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