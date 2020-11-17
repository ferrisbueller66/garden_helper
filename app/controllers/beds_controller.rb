class BedsController < ApplicationController

  before_action :bed_finder, only: [:show, :edit, :update]

  def index
    #TODO: add user_signed_in? to before_action to reduce code redundancy in all these controller actions
    if user_signed_in?
      @beds = current_user.beds.uniq {|b| b.id}
    else
      redirect_to root_path
    end
  end

  def create
    if user_signed_in?
      @bed = Bed.create(bed_params)
      if @bed.valid?
        redirect_to @bed
      else
        render :new
      end
    else
      redirect_to root_path
    end
  end

  def new
    if user_signed_in?
      @plant = current_user.plants.build
      @bed = @plant.build_bed
    else
      redirect_to root_path
    end
  end

  def edit
    if @bed  
      render :edit
    else
      redirect_to beds_path
    end
  end

  def show
    if @bed
      render :show
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
    if user_signed_in?
      @bed = current_user.beds.find_by(id: params[:id])
    else
      redirect_to root_path
    end
  end

end