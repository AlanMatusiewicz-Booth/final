class SavedRecipesController < ApplicationController
  def index
    matching_saved_recipes = SavedRecipe.where({ :user_id => @current_user.id })

    @list_of_saved_recipes = matching_saved_recipes.order({ :created_at => :desc })
    # @list_of_saved_recipes = matching_saved_recipes.order({ :created_at => :desc })

    @saved_id_array = Array.new
    @list_of_saved_recipes.each do |a_saved_recipe|
      @saved_id_array.push(a_saved_recipe.recipe_id)
    end

    matching_recipes = Recipe.where({ :user_id => @current_user.id })

    @list_of_recipes = matching_recipes.order({ :name => :asc })

    render({ :template => "saved_recipes/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_saved_recipes = SavedRecipe.where({ :id => the_id })

    @the_saved_recipe = matching_saved_recipes.at(0)

    render({ :template => "saved_recipes/show.html.erb" })
  end

  def create
    if params.has_key?(:query_source_url) == false
      @source_url = "/saved_recipes"
    else
      @source_url = params.fetch("query_source_url")
    end
    
    the_saved_recipe = SavedRecipe.new
    the_saved_recipe.user_id = @current_user.id
    the_saved_recipe.recipe_id = params.fetch("query_recipe_id")
    
    if the_saved_recipe.valid?
      the_saved_recipe.save
      redirect_to("#{@source_url}", { :notice => "Recipe saved successfully." })
    else
      redirect_to("#{@source_url}", { :alert => "#{the_saved_recipe.errors.full_messages.to_sentence}" })
    end
  end

  def destroy
    if params.has_key?(:query_source_url) == false
      @source_url = "/saved_recipes"
    else
      @source_url = params.fetch("query_source_url")
    end

    the_id = params.fetch("query_saved_recipe_id")
    the_saved_recipe = SavedRecipe.where({ :id => the_id }).at(0)

    the_saved_recipe.destroy

    redirect_to("#{@source_url}", { :notice => "Saved recipe deleted successfully."} )
  end
end
