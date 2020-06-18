class HarvestsController < ApplicationController

  before_action :log
  
  def show
    if params[:plant_id]
      @plant = Plant.find_by(id: params[:plant_id])
        if @plant
          @harvest = Harvest.find_by(id: params[:id])
          if @harvest
            render :show
          else
            redirect_to @plant
          end
        else
          redirect_to plants_path
        end
      else
        @harvest = Harvest.find_by(id: params[:id])
          render :show
      end
    
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
    
    if params[:harvest][:plant_id]
      @plant = Plant.find_by(id: params[:harvest][:plant_id])
      if @plant
      @harvest = @plant.harvests.build(harvest_params)
      @harvest.save
        if @harvest.valid?
          @plant.harvest_status
          redirect_to plant_harvest_path(@plant, @harvest)
        else
          render :new
        end
      else
        redirect_to plants_path
      end
    else
      redirect_to plants_path
    end
  end

  def edit
    if params[:plant_id]
      @plant = Plant.find_by(id: params[:plant_id])
      if @plant
        @harvest = Harvest.find_by(id: params[:id])
    
          if @harvest
            render :edit
          else
            redirect_to @plant
          end
      else
        redirect_to @plants
      end
    else
      @harvest = Harvest.find_by(id: params[:id])
      if @harvest
        render :edit
      else
        redirect_to plants_path
      end
    end
  end

  def update

    if params[:plant_id]
      @plant = Plant.find_by(id: params[:plant_id])
      if @plant
        @harvest = Harvest.find_by(id: params[:id])
          if @harvest
            @harvest = Harvest.update(harvest_params)
              if @harvest.valid?
                redirect_to plant_path(@harvest.plant) #@plant
              else
                flash[:alert] = @plant.errors.full_messages
                render :edit
              end
          else
            redirect_to @plant
          end
      else
        redirect_to plants_path
      end
    else
      redirect_to plants_path
    end
  end


  private

  def harvest_params
    params.require(:harvest).permit(:plant_id, :weight, :harvest_date)
  end

end
