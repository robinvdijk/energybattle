class TeamRelation < ActiveRecord::Base
  belongs_to :battle
  belongs_to :user
  validates :battle_id, presence: true
end