class PlantsController < ApplicationController
  def index
    @plants = current_user.plants.all
  end

  def show
    @plant = Plant.find_by(id: params[:id])
  end

  def new
  end

  def create
  end
end
