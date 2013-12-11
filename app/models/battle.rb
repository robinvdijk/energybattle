class Battle < ActiveRecord::Base
  has_many :users, through: :team_relations
  has_many :team_relations
  has_many :readings

  validates :host_id, presence: true
  validates :status, presence: true
  validates :duration, presence: {message: "Moet ingevuld zijn"}
  validates :title, presence: {message: "Moet ingevuld zijn"}, length: {maximum: 25}

  validates :player_limit, presence: {message: "Moet ingevuld zijn"}, :numericality => { :only_integer => true, less_than_or_equal_to: 16# , greater_than: 1
  }
  validates :start_date, presence: {message: "Moet ingevuld zijn"}

  after_create :create_host_team_relation

  before_save :end_date

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

  def in_battle?(current_user)
    TeamRelation.where(battle_id: self.id, user_id: current_user.id).first
  end

  def uploads_prepared?
    self.users.map { |u| u.readings.where(battle_id: self.id) }.count == self.player_limit
  end

  def team_full?(team)
    self.team_relations.where(team: "#{team}_team").count == self.player_limit / 2
  end

  def self.update_battles
    battles = Battle.where(:end_date == Date.today)
    for battle in battles do
      battle.update_attribute(:status, "closing")
    end
  end

  def points(user)
    a1 = self.users.where(id: user.id).first.readings.where(battle_id: self.id).first.amount
    a2 = self.users.where(id: user.id).first.readings.where(battle_id: self.id).last.amount
    baseline = (user.readings.first.amount/365.to_f)*self.duration
    s = 12
    i = 30
    (1-((a2-a1)/baseline))*100*s+i
  end

  def end_date
    self.end_date = self.start_date + self.duration
  end
end
