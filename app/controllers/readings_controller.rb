class ReadingsController < ApplicationController
  before_action :higher_value

  def index
    @readings = Reading.all
  end

  def new
    @reading = Reading.new
  end

  def create
    @reading = Reading.new(reading_params)
    if Reading.any?  
      if @reading.amount >= @reading_value
        @reading.save
        flash[:succes] = "Gelukt"
      else
        render 'new'
      end
    else
      if @reading.save
        flash[:succes] = "Gelukt"
      else
        render 'new'
      end
    end
  end

  def show
    @reading = Reading.find(params[:id])
  end

  private

  def reading_params
    params.require(:reading).permit(:amount, :meter)
  end

  def higher_value
    if Reading.any?
      @reading_value = Reading.order("created_at").last.amount
    else
      @reading_value = nil
    end
  end
end
