class ReadingsController < ApplicationController
  def index
    @readings = Reading.all
  end

  def new
  	@reading = Reading.new
  end

  def create
  	@reading = Reading.new(reading_params)
  	if @reading.save
  		redirect_to meterstanden_path
  	else
  		render 'new'
  	end
  end

  def show
    @reading = Reading.find(params[:id])
  end

  private

  def reading_params
  	params.require(:reading).permit(:amount)
  end
end
