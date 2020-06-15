class BedsController < ApplicationController
  def index
    @beds = Bed.all#current_user.beds.all
  end

  def show
    @bed = Bed.find_by(id: params[:id])
  end

  def new
  end

  def create
  end
end
