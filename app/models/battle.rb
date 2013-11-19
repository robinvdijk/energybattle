class Battle < ActiveRecord::Base
  has_many :users, through: :team_relations
  has_many :team_relations
  has_many :readings
    
  validates :host_id, presence: true
  validates :status, presence: true
  validates :title, presence: {message: "Moet ingevuld zijn"}, length: {maximum: 25}
  validates :player_limit, presence: {message: "Moet ingevuld zijn"}, length: {minimum: 2}, :numericality => { :only_integer => true }
  validates :start_date, presence: {message: "Moet ingevuld zijn"} 

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

  def end_battles
    battles = Battle.where(:end_date == Date.today)
    for battle in battles do
      battle.status = "closing"
    end
  end
end



