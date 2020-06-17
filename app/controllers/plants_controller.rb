class PlantsController < ApplicationController
  def index
    @plants = current_user.plants.all
  end

  def show
    
    @bed = Bed.find_by(id: params[:bed_id])
    if @bed
      @plant = Plant.find_by(id: params[:id])
      if @plant
        render :show
      else
        redirect_to plants_path
      end
    else
      redirect_to beds_path
    end
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.create(plant_params)
    if @plant.valid?
      redirect_to @plant
    else
      flash[:alert] = @plant.errors.full_messages
      render :new
    end
  end

  private

  def plant_params
    params.require(:plant).permit(:user_id, :variety, :nickname, :species, :description, :germination_date, :transplant_date, :bed_id)
  end
end
