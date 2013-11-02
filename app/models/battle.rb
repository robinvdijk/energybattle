class Battle < ActiveRecord::Base
  has_many :users, through: :team_relations
  validates :host_id, presence: true

  after_create :host_team_relation

  def host_team_relation
    r = TeamRelation.new
    r.user_id = self.host_id
    r.battle_id = self.id
    r.team = "host_team"
    r.save
  end

  def status?(value)
    self.status == value
  end
end
