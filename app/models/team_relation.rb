class TeamRelation < ActiveRecord::Base
  belongs_to :battle
  belongs_to :user
  validates :battle_id, presence: true

  before_destroy :host_team_relation?

  def host_team_relation?
    self.battle.destroy if self.battle.host_id == self.user_id
  end
  
  
end