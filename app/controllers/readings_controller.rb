class ReadingsController < ApplicationController
  before_action :higher_value

	respond_to :json, :html

  def index
    @readings = Reading.all
  end

  def new
    @reading = Reading.new
  end

  def create
    @reading = Reading.new(reading_params)

    if Reading.any?  
      if @reading.amount >= @reading_value && @reading.save
        flash[:succes] = "Gelukt"
        exif = EXIFR::JPEG.new(Rails.root.join('public', 'uploads', 'reading', 'meter', "#{@reading.id}", "#{File.basename(@reading.meter_url)}").to_s)
        @reading.original_date = exif.date_time if exif.date_time
        @reading.save
        redirect_to @reading.battle
      else
        flash[:alert] = "Er is iets mis gegaan"
        redirect_to @reading.battle
      end
    else
      if @reading.save
        flash[:succes] = "Gelukt"
        exif = EXIFR::JPEG.new(Rails.root.join('public', 'uploads', 'reading', 'meter', "#{@reading.id}", "#{File.basename(@reading.meter_url)}").to_s)
        @reading.original_date = exif.date_time if exif.date_time
        @reading.save
        redirect_to @reading.battle
      else
         redirect_to @reading.battle
      end
    end
  end
  

  def show
    @reading = Reading.find(params[:id])
  end

  private

  def reading_params
    params.require(:reading).permit(:amount, :meter, :user_id, :battle_id, :original_date)
  end

  def higher_value
    if Reading.any?
      @reading_value = Reading.order("created_at").last.amount
    else
      @reading_value = nil
    end
  end

end
