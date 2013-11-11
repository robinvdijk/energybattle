class Battle < ActiveRecord::Base
  has_many :users, through: :team_relations
  has_many :team_relations
  has_many :readings
    
  validates :host_id, presence: true
  validates :status, presence: true
  validates :theme, presence: true
  validates :title, presence: true, length: {maximum: 25}

  after_create :create_host_team_relation
  

  def create_host_team_relation
    r = TeamRelation.new
    r.user_id = self.host_id
    r.battle_id = self.id
    r.team = "host_team"
    r.status = 'joined'
    r.save
  end
  
  def status?(value)
    self.status == value
  end
end



