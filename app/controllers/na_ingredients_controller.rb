class NaIngredientsController < ApplicationController
  def index
    matching_na_ingredients = NaIngredient.all

    @list_of_na_ingredients = matching_na_ingredients.order({ :created_at => :desc })

    render({ :template => "na_ingredients/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_na_ingredients = NaIngredient.where({ :id => the_id })

    @the_na_ingredient = matching_na_ingredients.at(0)

    render({ :template => "na_ingredients/show.html.erb" })
  end

  def create
    the_na_ingredient = NaIngredient.new
    the_na_ingredient.recipe_id = params.fetch("query_recipe_id")
    the_na_ingredient.name = params.fetch("query_name")
    the_na_ingredient.measure = params.fetch("query_measure")
    the_na_ingredient.unit = params.fetch("query_unit")

    if the_na_ingredient.valid?
      the_na_ingredient.save
      redirect_to("/na_ingredients", { :notice => "Na ingredient created successfully." })
    else
      redirect_to("/na_ingredients", { :notice => "Na ingredient failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_na_ingredient = NaIngredient.where({ :id => the_id }).at(0)

    the_na_ingredient.recipe_id = params.fetch("query_recipe_id")
    the_na_ingredient.name = params.fetch("query_name")
    the_na_ingredient.measure = params.fetch("query_measure")
    the_na_ingredient.unit = params.fetch("query_unit")

    if the_na_ingredient.valid?
      the_na_ingredient.save
      redirect_to("/na_ingredients/#{the_na_ingredient.id}", { :notice => "Na ingredient updated successfully."} )
    else
      redirect_to("/na_ingredients/#{the_na_ingredient.id}", { :alert => "Na ingredient failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_na_ingredient = NaIngredient.where({ :id => the_id }).at(0)

    the_na_ingredient.destroy

    redirect_to("/na_ingredients", { :notice => "Na ingredient deleted successfully."} )
  end
end
