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
    if Reading.any?
      if @reading.save && @reading.amount >= current_user.readings.last.amount
        flash[:success] = "Gelukt"
        exif = EXIFR::JPEG.new(Rails.root.join('public', 'uploads', 'reading', 'meter', "#{@reading.id}", "#{File.basename(@reading.meter_url)}").to_s)
        @reading.original_date = exif.date_time if exif.date_time
        @reading.save
        if @reading.battle.status?("closing")
          @reading.battle.update_attribute(:status, "finished")
        end
        redirect_to @reading.battle
      else
        redirect_to @reading.battle
        flash[:alert] = "Er is iets mis gegaan"
      end
    else
      if @reading.save
        flash[:success] = "Gelukt"
        exif = EXIFR::JPEG.new(Rails.root.join('public', 'uploads', 'reading', 'meter', "#{@reading.id}", "#{File.basename(@reading.meter_url)}").to_s)
        @reading.original_date = exif.date_time if exif.date_time
        @reading.save
        redirect_to @reading.battle
      else
        flash[:alert] = "Er is iets mis gegaan"
        render "form"
      end
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