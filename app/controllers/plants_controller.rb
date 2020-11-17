class PlantsController < ApplicationController
  before_action :plant_finder, only: [:edit, :update]

  def index
    if user_signed_in?
      @plants = current_user.plants.all
      @harvested_plants = @plants.been_harvested
      @ordered_plants = current_user.plants.alpha_sort
    else
      redirect_to plants_path
    end
  end

  def create
    if user_signed_in?
      @plant = current_user.plants.create(plant_params)
      if @plant.valid?
        redirect_to @plant
      else
        render :new
      end
    else
      redirect_to root_path
    end
  end

  def new
    if user_signed_in?
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
    else
      redirect_to root_path
    end
  end

  def edit
    if @plant  
      render :edit
    else
      redirect_to plants_path
    end
  end

  def show
    if user_signed_in?
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
    else
      redirect_to root_path
    end
  end

  def update
    if @plant.update(plant_params)
      redirect_to plant_path(@plant)
    else
      render :edit
    end
  end

  # TODO: Build out DELETE ACTION
  # def delete
  #   if @plant.update(plant_params)
  #     redirect_to plants_path
  #   else
  #     render :edit
  #   end
  # end

  private

  def plant_params
    params.require(:plant).permit(:user_id, :variety, :nickname, :species, :description, :germination_date, :transplant_date, :bed_id, :bed_attributes => [:name])
  end

  def plant_finder
    if user_signed_in?
      @plant = current_user.plants.find_by(id: params[:id])
    else
      redirect_to root_path
    end
  end

end