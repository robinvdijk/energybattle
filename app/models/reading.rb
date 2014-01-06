class Reading < ActiveRecord::Base
  require 'open-uri'
  METER_UPLOAD_PATH = 'public/uploads/reading/meter'

  validates :amount, presence: {message: "Moet ingevuld zijn"}, :numericality => { :only_integer => true }
  mount_uploader :meter, MeterUploader

  # validates :meter, presence: {message: "Moet upgeload zijn"} # disable om populate te gebruiken

  belongs_to :user
  belongs_to :battle

  # after_create :exif_data
  # after_create :closing_reading

  def exif_data
    exif = EXIFR::JPEG.new(Rails.root.join(METER_UPLOAD_PATH, "#{self.id}", "#{File.basename(self.meter_url)}").to_s)
    self.update_attributes(:original_date => exif.date_time) if exif.date_time
  end


  def closing_reading
    if self.battle.status == 'closing'
      self.battle.update_attribute(:status, 'finished')
    end
  end

  def self.personal_chart_data(battle, current_user)
    start_date = battle.start_date
    end_date = battle.end_date
    personal_readings = Reading.where(battle_id: battle.id, user_id: current_user.id)
    reading_by_day = personal_readings.amount_of_day(start_date, end_date)

    # growth = verschil in laatste twee readings / verschil in dagen daartussen
    growth = (personal_readings.last.amount - personal_readings.order("id DESC").offset(1).first.amount) / (personal_readings.last.created_at.to_date - personal_readings.order("id DESC").offset(1).first.created_at.to_date).to_i if personal_readings.count > 1

    counter = 0
    first_reading = current_user.readings.first
    (start_date.to_date..end_date.to_date).map do |date|
      if date > personal_readings.last.created_at.to_date
        counter+=1
        {
          original_date: date,
          personal: reading_by_day[date],
          ideal: personal_readings.last.amount + growth.to_i * counter,
          expected: first_reading.amount + (first_reading.amount/365) * (date - first_reading.created_at.to_date).to_i
        }
      else
        counter = 0
        {
          original_date: date,
          personal: reading_by_day[date],
          ideal: reading_by_day[date]
        }
      end
    end
  end

  def self.amount_of_day(start_date, end_date)
    readings = where(created_at: start_date..end_date)
    readings = readings.group("date(created_at)")
    readings.each_with_object({}) do |reading, amounts|
      amounts[reading.created_at.to_date] = reading.amount
    end
  end

  def self.overall_chart_data(battle, current_user)
    output = {}

    start_date = battle.start_date
    end_date = battle.end_date
    # overall_readings = where(battle_id: battle.id)
    # name_of_members = battle.users.pluck(:name).first
    # reading_by_name = overall_readings.amount_of_each_member(start_date, end_date)

    readings = battle.readings.includes(:user).where(created_at: start_date.to_date..end_date.to_date)
    readings_by_date = readings.inject({}) do |hsh, r|
      hsh[r.created_at.to_date] = [] unless hsh.key?(r.created_at.to_date)

      hsh[r.created_at.to_date] << r
      hsh
    end
    labels = []

    data = readings_by_date.map do |date, readings|
      hsh = {
        date: date
      }

      for reading in readings
        hsh[reading.user_id] = reading.amount
        labels << reading.user.name
      end

      hsh
    end

    keys = data.first.keys
    keys.shift
    labels.shift

    battleUsersId = battle.users.pluck(:id)
    users = Hash[battleUsersId.map.with_index.to_a]
    index = users[current_user.id]
    lineColors = []
    battleUsersId.count.times do |i|
      if i == index
        lineColors << '#0b62a4'
      else
        lineColors << '#999'
      end
    end

    output['data'] = data
    output['xkey'] = 'date'
    output['element'] = 'line-example'
    output['ykeys'] = keys
    output['labels'] = labels
    output['element'] = 'overall-graph'
    output['lineColors'] = lineColors

    output
  end

  def self.team_vs_team_chart_data(battle)
    output = {}

    start_date = battle.start_date
    end_date = battle.end_date
    # overall_readings = where(battle_id: battle.id)
    # name_of_members = battle.users.pluck(:name).first
    # reading_by_name = overall_readings.amount_of_each_member(start_date, end_date)

    readings = battle.readings.includes(:user).where(created_at: start_date.to_date..end_date.to_date)
    readings_by_date = readings.inject({}) do |hsh, r|
      hsh[r.created_at.to_date] = [] unless hsh.key?(r.created_at.to_date)

      hsh[r.created_at.to_date] << r
      hsh
    end
    labels = []

    data = readings_by_date.map do |date, readings|
      hsh = {
        date: date
      }

      for reading in readings
        hsh[reading.user_id] = reading.amount
        labels << reading.user.name
      end

      hsh
    end

    keys = data.first.keys
    keys.shift
    labels.shift

    lineColors = []
    battle.users.pluck(:id).each do |i|
      if battle.team_relations.where(user_id: i)[0].team == "host_team"
        lineColors << '#999'
      else
        lineColors << '#0b62a4'
      end
    end

    output['data'] = data
    output['xkey'] = 'date'
    output['element'] = 'line-example'
    output['ykeys'] = keys
    output['labels'] = labels
    output['element'] = 'overall-graph'
    output['lineColors'] = lineColors

    output
  end

  def self.consumption_chart_data(current_user)
    start_date = current_user.created_at.to_date
    end_date = 2.weeks.from_now.to_date
    personal_readings = Reading.where(user_id: current_user.id)
    reading_by_day = personal_readings.amount_of_day(start_date, end_date)

    # growth = verschil in laatste twee readings / verschil in dagen daartussen
    growth = (personal_readings.last.amount - personal_readings.order("id DESC").offset(1).first.amount) / (personal_readings.last.created_at.to_date - personal_readings.order("id DESC").offset(1).first.created_at.to_date).to_i

    counter = 0
    (start_date.to_date..end_date.to_date).map do |date|
      if date > personal_readings.last.created_at.to_date
        counter+=1
        {
          original_date: date,
          personal: reading_by_day[date],
          ideal: personal_readings.last.amount + growth.to_i * counter
        }
      else
        counter = 0
        {
          original_date: date,
          personal: reading_by_day[date],
          ideal: reading_by_day[date]
        }
      end
    end
  end
end