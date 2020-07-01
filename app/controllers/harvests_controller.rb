class HarvestsController < ApplicationController

  def show
    if user_signed_in?
      if params[:plant_id]
        @plant = current_user.plants.find_by(id: params[:plant_id])
        if @plant
          @harvest = current_user.harvests.find_by(id: params[:id])
          if @harvest
            render :show
          else
            redirect_to @plant
          end
        else
          redirect_to plants_path
        end
      else
        @harvest = current_user.harvests.find_by(id: params[:id])
        render :show
      end
    else
      redirect_to root_path
    end
  end

  def new
    if user_signed_in?
      if params[:plant_id]
        @plant = current_user.plants.find_by(id: params[:plant_id])
        if @plant
          @harvest = @plant.harvests.build
        else
          redirect_to plants_path
        end
      else
        redirect_to plants_path
      end
    else
      redirect_to root_path
    end
  end

  def create
    if user_signed_in?
      if params[:harvest][:plant_id]
        @plant = current_user.plants.find_by(id: params[:harvest][:plant_id])
        if @plant
          @harvest = @plant.harvests.create(harvest_params)
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
    else
      redirect_to root_path
    end
  end

  def edit
    if user_signed_in?
      if params[:plant_id]
        @plant = current_user.plants.find_by(id: params[:plant_id])
        if @plant
          @harvest = current_user.harvests.find_by(id: params[:id])
          if @harvest
            render :edit
          else
            redirect_to @plant
          end
        else
          redirect_to plants_path
        end
      else
        redirect_to plants_path
      end
    else
      redirect_to root_path
    end
  end

  def update
    if user_signed_in?
      if params[:harvest][:plant_id]
        @plant = current_user.plants.find_by(id: params[:harvest][:plant_id])
        if @plant
          @harvest = current_user.harvests.find_by(id: params[:id])
          if @harvest
            @harvest.update(harvest_params)
            if @harvest.valid?
              redirect_to plant_harvest_path(@plant, @harvest)
            else
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
    else
      redirect_to root_path
    end
  end


  def destroy
    if user_signed_in?
      if params[:id]
        @plant = current_user.plants.find_by(id: params[:id])
        if @plant
          @harvest = current_user.harvests.find_by(id: params[:format])
          if @harvest
            @harvest.destroy
            redirect_to @plant
          else
            redirect_to @plant
          end
        else
          redirect_to plants_path
        end
      else
        redirect_to plants_path
      end
    else
      redirect_to root_path
    end

  end

  private

  def harvest_params
    params.require(:harvest).permit(:plant_id, :weight, :harvest_date)
  end

end
