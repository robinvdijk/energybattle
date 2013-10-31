class User < ActiveRecord::Base
  has_many :single_battles, through: :team_relations
  validates :first_name, presence: true
end
