class RecipesController < ApplicationController

def index
    user = User.find_by(id: session[:user_id])
    if user
        recipes = Recipe.all 
        render json: recipes, include: :user
    else
        render json: { "errors": ["Not authorized"] }, status: :unauthorized
    end
end

def create 
    user=User.find_by(id: session[:user_id])
    recipe=Recipe.create(recipe_params)
    if user
        
        if recipe.valid?
            render json: recipe, status: :created
        else
            render json: { "errors": ["Validation errors"] }, status: :unprocessable_entity
        end
    else
        render json: { "errors": ["Not authorized"] }, status: :unauthorized
    end
end
    


private

def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete, :user_id)
end

end
