class User < ActiveRecord::Base
  has_many :single_battles
  validates :first_name, presence: true
end
