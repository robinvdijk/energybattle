class Reading < ActiveRecord::Base
  require 'open-uri'
  
	validates :amount, presence: true, :numericality => { :only_integer => true }
	mount_uploader :meter, MeterUploader

	validates :meter, presence: true

	belongs_to :user
  belongs_to :battle
  
  
  def self.test
    self.update_attributes(:original_date => exif)
    self.save
  end
end


