class AlcoholsController < ApplicationController
  def index
    matching_alcohols = Alcohol.all

    @list_of_alcohols = matching_alcohols.order({ :created_at => :desc })

    render({ :template => "alcohols/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_alcohols = Alcohol.where({ :id => the_id })

    @the_alcohol = matching_alcohols.at(0)

    render({ :template => "alcohols/show.html.erb" })
  end

  def create
    the_alcohol = Alcohol.new
    the_alcohol.name = params.fetch("query_name").downcase

    if the_alcohol.valid?
      the_alcohol.save
      redirect_to("/bar/bottles", { :notice => "Alcohol created successfully." })
    else
      redirect_to("/bar/bottles", { :alert => "#{the_alcohol.errors.full_messages.to_sentence}" })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_alcohol = Alcohol.where({ :id => the_id }).at(0)

    the_alcohol.name = params.fetch("query_name")
    the_alcohol.description = params.fetch("query_description")

    if the_alcohol.valid?
      the_alcohol.save
      redirect_to("/alcohols/#{the_alcohol.id}", { :notice => "Alcohol updated successfully."} )
    else
      redirect_to("/alcohols/#{the_alcohol.id}", { :alert => "Alcohol failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_alcohol = Alcohol.where({ :id => the_id }).at(0)

    the_alcohol.destroy

    redirect_to("/alcohols", { :notice => "Alcohol deleted successfully."} )
  end
end
