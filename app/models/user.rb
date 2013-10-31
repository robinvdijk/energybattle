class User < ActiveRecord::Base
  has_many :battles, through: :team_relations
  validates :first_name, presence: true
end
