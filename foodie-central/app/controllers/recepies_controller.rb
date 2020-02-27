class RecipesController < ApplicationController
    
    before do
        require_login
    end

    # CREATE
    get '/recipes/new' do
        erb :'/recipes/new'
    end
    
    post '/recipes' do
        recipe = current_user.recipes.build(params)
        if recipe.save
            redirect '/recipes'
        else
            flash.now[:error] = "All fields must be filled out. Please try again."
            erb :'/recipes/new'
        end
    end

    # READ
    get '/recipes' do
        @recipes = Recipe.all
        erb :'recipes/index'
    end

    get '/recipes/:id' do
        @recipe = Recipe.find_by(id: params[:id])
        if @recipe
            erb :'recipes/show'
        else
            redirect '/recipes'
        end
    end

    # UPDATE
    get '/recipes/:id/edit' do
        @recipe = Recipe.find(params[:id])
        if authorized_user(@recipe)
            erb :'recipes/edit'
        else
            # flash message youre not authorized to edit recipe.
            flash.now[:error] = "You are not authorized to edit this recipe."
            redirect '/recipes'
        end
    end

    patch '/recipes/:id' do
        @recipe = Recipe.find(params[:id])
        if !params["recipe"]["title"].empty? && !params["recipe"]["instructions"].empty? && !params["recipe"]["cook_time"].empty?
        @recipe.update(params["recipe"])
        redirect "/recipes/#{@recipe.id}"
        else
            flash.now[:error] = "All fields must be filled out. Please try again."
            erb :'/recipes/edit' 
        end
    end

    # DELETE
    delete '/recipes/:id' do
        recipe = Recipe.find(params[:id])
        recipe.destroy
        redirect '/recipes'
    end
    
end