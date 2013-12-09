class Reading < ActiveRecord::Base
  require 'open-uri'
	METER_UPLOAD_PATH = 'public/uploads/reading/meter'

	validates :amount, presence: {message: "Moet ingevuld zijn"}, :numericality => { :only_integer => true }
	mount_uploader :meter, MeterUploader

	# validates :meter, presence: {message: "Moet upgeload zijn"} # disable om populate te gebruiken

	belongs_to :user
  belongs_to :battle

	#after_create :exif_data
	after_create :closing_reading

	def exif_data
    exif = EXIFR::JPEG.new(Rails.root.join(METER_UPLOAD_PATH, "#{self.id}", "#{File.basename(self.meter_url)}").to_s)
		self.update_attributes(:original_date => exif.date_time) if exif.date_time
	end

	def closing_reading
		if self.battle.status?('closing')
			self.battle.update_attribute(:status, 'finished')
		end
	end

  def self.personal_chart_data(battle, current_user)
    start_date = battle.start_date
    end_date = battle.end_date
    personal_readings = where(battle_id: battle.id, user_id: current_user.id)
    reading_by_day = personal_readings.amount_of_day(start_date, end_date)

    growth = (personal_readings.last.amount - personal_readings.order("id DESC").offset(1).first.amount)

    (start_date.to_date..end_date.to_date).map do |date|
      days_gone = start_date..date
      {
        original_date: date,
        personal: reading_by_day[date],
        ideal: reading_by_day[date] || personal_readings.last.amount + growth.to_i * (days_gone.count)
      }
    end
  end

  def self.amount_of_day(start_date, end_date)
    readings = where(created_at: start_date.to_date..end_date.to_date)
    readings = readings.group("date(created_at)")
    readings.each_with_object({}) do |reading, amounts|
      amounts[reading.created_at.to_date] = reading.amount
    end
  end

  def self.growth(start_date, end_date, personal_readings)
    growth = (personal_readings.last.amount - personal_readings.order("id DESC").offset(1).first.amount)
    last_reading = personal_readings.last.amount
    (start_date.to_date..end_date.to_date).each_with_object({}) do |date, amounts|
      amounts[date] = last_reading
    end
  end

  def self.overall_chart_data(battle)
    start_date = battle.start_date
    end_date = battle.end_date
    overall_readings = where(battle_id: battle.id)
    name_of_members = battle.users.pluck(:name).first
    reading_by_name = overall_readings.amount_of_each_member(start_date, end_date)

    (start_date.to_date..end_date.to_date).map do |date, name_of_members|
      {
        original_date: date,
        user1: reading_by_name[0][name_of_members][date],
        user2: reading_by_name[3]["Zetta Reichert I"][date]
      }
    end
  end

  def self.amount_of_each_member(start_date, end_date)
    readings = where(created_at: start_date.to_date..end_date.to_date)
    readings.map do |reading|
      results = Hash.new do |hash, key|
        hash = {}
      end

      arr = [[reading.user.name, reading.created_at.to_date, reading.amount]]
      arr.each do |sub_arr|
        main_key = sub_arr[0]
        sub_key = sub_arr[1]

        results[main_key][sub_key] = sub_arr[2]
      end
      results
    end
  end
end