class HarvestsController < ApplicationController
  def index
    @harvests = current_user.harvests
  end

  def show
  end

  def new
  end

  def create
  end
end
