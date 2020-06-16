class PlantsController < ApplicationController
  def index
    @plants = current_user.plants.all
  end

  def show
    @plant = Plant.find_by(id: params[:id])
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.create(plant_params)
    if @plant.valid?
      redirect_to @plant
    else
      flash[:alert] = @plant.errors.full_messages
      render :new
    end
  end

  private

  def plant_params
    params.require(:plant).permit(:user_id, :variety, :nickname, :species, :description, :germination_date, :transplant_date, :bed_id)
  end
end
