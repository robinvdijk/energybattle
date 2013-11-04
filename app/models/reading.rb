class Reading < ActiveRecord::Base
	validates :amount, presence: true, :numericality => { :only_integer => true }
	mount_uploader :meter
end
