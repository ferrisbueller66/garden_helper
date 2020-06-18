class PlantsController < ApplicationController
  before_action :log
  
  def index
    @plants = current_user.plants.all
  end

  def show
    if params[:bed_id]
    @bed = current_user.beds.find_by(id: params[:bed_id])
      if @bed
        @plant = current_user.plants.find_by(id: params[:id])
        if @plant
          render :show
        else
          redirect_to plants_path
        end
      else
        redirect_to beds_path    
      end
    else
      @plant = current_user.plants.find_by(id: params[:id])
      if @plant  
        render :show
      else
        redirect_to plants_path
      end
    end
  end

  def new
    if params[:bed_id]
      @bed = current_user.beds.find_by(id: params[:bed_id])
      if @bed
        @plant = current_user.plants.build
      else
        redirect_to beds_path
      end
    else
      @plant = current_user.plants.build
      @newbed = @plant.build_bed
    end
  end

  def create
    @plant = current_user.plants.create(plant_params)
    if @plant.valid?
      redirect_to @plant
    else
      render :new
    end
  end

  def edit
    @plant = current_user.plants.find_by(id: params[:id])
    if @plant  
      render :edit
    else
      redirect_to plants_path
    end
  end

  def update
    @plant = current_user.plants.find_by(id: params[:id])
    if @plant.update(plant_params)
      redirect_to plant_path(@plant)
    else
      render :edit
    end
  end

  private

  def plant_params
    params.require(:plant).permit(:user_id, :variety, :nickname, :species, :description, :germination_date, :transplant_date, :bed_id, :bed_attributes => [:name])
  end


end
