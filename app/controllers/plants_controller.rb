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
      @bed = Bed.find_by(id: params[:bed_id])
      if @bed
        @plant = Plant.new                #correct this to current_user.plants.build
      else
        redirect_to beds_path
      end
    else
      @plant = Plant.new
      @newbed = Bed.new
    end
  end

  def create
    @plant = current_user.plants.build(plant_params)
    @plant.save
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
    params.require(:plant).permit(:user_id, :variety, :nickname, :species, :description, :germination_date, :transplant_date, :bed_id, :bed_attributes => [:name])
  end


end
