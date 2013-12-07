class ReadingsController < ApplicationController
  before_action :set_readings, only: [:show]

  def index
    if params[:battle_id].present?
      @readings = Reading.where(:battle_id => params[:battle_id]).order(:user_id).map
    else
      @readings = Reading.distinct(:created_at)
    end
  end

  def new
    @reading = Reading.new
  end

  def create
    @reading = Reading.new(reading_params)
    check_amount = @reading.amount >= current_user.readings.last.amount if current_user.readings.any?
    if check_amount
      @reading.save
      redirect_to @reading.battle, success: "Gelukt"
    else
      flash[:error] = "Er is iets mis gegaan"
      redirect_to :back
    end
  end

  def show
  end

private
  def set_reading
    @reading = Reading.find(params[:id])
  end

  def reading_params
    params.require(:reading).permit(:amount, :meter, :user_id, :battle_id, :original_date)
  end
end