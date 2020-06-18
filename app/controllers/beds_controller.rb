class BedsController < ApplicationController

  before_action :log

  def index
    @beds = current_user.beds.uniq {|b| b.id}
  end

  def show
    @bed = current_user.beds.find_by(id: params[:id])
    if @bed
      render :show
    else
      redirect_to beds_path
    end
  end

  def new
    @bed = Bed.new
    @plant = @bed.plants.build(variety: 'First Plant')
  end

  def create
    @bed = Bed.create(bed_params)
    if @bed.valid?
      redirect_to @bed
    else
      flash[:alert] = @bed.errors.full_messages
      
      render :new
    end
  end

  def edit
    @bed = Bed.find_by(id: params[:id])
   
  end

  def update
    @bed = Bed.find_by(id: params[:id])
    if @bed.update(bed_params)
      redirect_to bed_path(@bed)
    else
      render :edit
    end
  end

  private

  def bed_params
    params.require(:bed).permit(:name, :location, :size, :medium, plants_attributes: [:variety, :user_id])
  end
end