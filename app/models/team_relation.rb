class TeamRelation < ActiveRecord::Base
  belongs_to :single_battle
  belongs_to :user
  validates :single_battle_id, presence: true
end