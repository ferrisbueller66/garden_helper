class HarvestsController < ApplicationController
  def index
    @harvests = current_user.harvests
  end

  def show
    @harvest = Harvest.find_by(id: params[:id])
  end

  def new
    if params[:plant_id]
      @plant = Plant.find_by(id: params[:plant_id])
        if @plant
          @harvest = Harvest.new
        else
          redirect_to plants_path
        end
    else
      @harvest = Harvest.new
    end
  end

  def create
    @harvest = Harvest.create(harvest_params)
    binding.pry
    if @harvest.valid?
      redirect_to plant_path(@harvest.plant)
    else
      flash[:alert] = @plant.errors.full_messages
      render :new
    end
  end

  private

  def harvest_params
    params.require(:harvest).permit(:plant_id, :weight, :harvest_date)
  end

end
