class ReadingsController < ApplicationController
  before_action :higher_value

	respond_to :json, :html

  def index
		if params[:battle_id].present?
	    @readings = Reading.where(:battle_id => params[:battle_id]).order(:user_id).map
      @personal_readings = Reading.where(:battle_id => params[:battle_id], user_id: current_user.id).map
		else
			@readings = Reading.distinct(:created_at)
		end
  end

	def test
		readings = Reading.order(:created_at)
		readings.each do |reading|

		end
		Reading.where("battle_id = ?", @battle.id)
	end

  def new
    @reading = Reading.new
  end

  def create
    @reading = Reading.new(reading_params)

    if Reading.any?
      if @reading.save && @reading.amount >= @reading_value
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
