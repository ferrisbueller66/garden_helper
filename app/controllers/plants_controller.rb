class PlantsController < ApplicationController
  before_action :log
  def index
    @plants = current_user.plants.all
  end

  def show
    if params[:bed_id]
    @bed = Bed.find_by(id: params[:bed_id])
      if @bed
        @plant = Plant.find_by(id: params[:id])
        if @plant
          render :show
        else
          redirect_to plants_path
        end
      else
        redirect_to beds_path
      end
    else
      @plant = Plant.find_by(id: params[:id])
        render :show
    end
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

  def edit
    @plant = Plant.find_by(id: params[:id])
  end

  def update
    @plant = Plant.find_by(id: params[:id])
    if @plant.update(plant_params)
      redirect_to plant_path(@plant)
    else
      render :edit
    end
  end

  private

  def plant_params
    params.require(:plant).permit(:user_id, :variety, :nickname, :species, :description, :germination_date, :transplant_date, :bed_id)
  end


end
