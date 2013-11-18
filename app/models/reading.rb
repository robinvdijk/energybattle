class Reading < ActiveRecord::Base
	validates :amount, presence: true, :numericality => { :only_integer => true }
	mount_uploader :meter, MeterUploader

	validates :meter, presence: true

	belongs_to :user
    belongs_to :battle
end
