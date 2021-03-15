class RecipesController < ApplicationController
  def index
    matching_recipes = Recipe.all

    @list_of_recipes = matching_recipes.order({ :name => :asc })

    render({ :template => "recipes/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_recipes = Recipe.where({ :id => the_id })

    @the_recipe = matching_recipes.at(0)

    render({ :template => "recipes/show.html.erb" })
  end

  def create
    @source_url = params.fetch("query_source_url")

    the_recipe = Recipe.new
    the_recipe.name = params.fetch("query_name")
    the_recipe.user_id = @current_user.id

    if the_recipe.valid?
      the_recipe.save
      redirect_to("/modify_recipe_form/#{the_recipe.id}", { :notice => "Recipe created successfully." })
    else
      redirect_to("/recipes", { :notice => "#{the_recipe.errors.full_messages.to_sentence}" })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_recipe = Recipe.where({ :id => the_id }).at(0)

    if params.has_key?(:query_iba_status) == false
      @iba_status = false
    else
      @iba_status = params.fetch("query_iba_status")
    end

    the_recipe.name = params.fetch("query_name")
    the_recipe.preparation = params.fetch("query_preparation")
    the_recipe.iba_status = @iba_status

    if the_recipe.valid?
      the_recipe.save
      redirect_to("/recipes/#{the_recipe.id}", { :notice => "Recipe updated successfully."} )
    else
      redirect_to("/recipes/#{the_recipe.id}", { :alert => "#{the_recipe.errors.full_messages.to_sentence}" })
    end
  end

  def update_form
    the_id = params.fetch("path_id")
    @the_recipe = Recipe.where({ :id => the_id }).at(0)
    
    render({ :template => "recipes/update_form.html.erb" })
  end

  def destroy
    the_id = params.fetch("path_id")
    the_recipe = Recipe.where({ :id => the_id }).at(0)

    the_recipe.destroy

    redirect_to("/recipes", { :notice => "Recipe deleted successfully."} )
  end

  def random
    the_id = Recipe.all.sample.id

    # Plan is for this notice to show only if user doesn't have all ingredients and specify what they need.
    redirect_to("/recipes/#{the_id}", { :notice => "Your bar may not have the ingredients needed for this random cocktail recipe." })
  end

end
