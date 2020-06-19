class BedsController < ApplicationController

  before_action :log, :bed_finder, only: [:show, :edit, :update]

  def index
    @beds = current_user.beds.uniq {|b| b.id}
  end

  def show
    if @bed
      render :show
    else
      redirect_to beds_path
    end
  end

  def new
    @plant = current_user.plants.build
    @bed = @plant.build_bed
  end

  def create
    @bed = Bed.create(bed_params)
    if @bed.valid?
      redirect_to @bed
    else
      render :new
    end
  end

  def edit
    if @bed  
      render :edit
    else
      redirect_to beds_path
    end
  end

  def update
    if @bed
      if@bed.update(bed_params)
        redirect_to bed_path(@bed)
      else
        render :edit
      end
    else
      redirect_to beds_path
    end
  end

  private

  def bed_params
    params.require(:bed).permit(:name, :location, :size, :medium, plant_ids: [], plants_attributes: [:variety, :user_id])
  end

  def bed_finder
    @bed = current_user.beds.find_by(id: params[:id])
  end
end