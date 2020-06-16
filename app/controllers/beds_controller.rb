class BedsController < ApplicationController
  def index
    @beds = current_user.beds.uniq {|b| b.id}
  end

  def show
    @bed = Bed.find_by(id: params[:id])
  end

  def new
    @bed = Bed.new
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

  private

  def bed_params
    params.require(:bed).permit(:name, :location, :size, :medium)
  end
end