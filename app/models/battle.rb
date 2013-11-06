class Battle < ActiveRecord::Base
  has_many :users, through: :team_relations
  has_many :team_relations
  
  has_many :notification
  
  validates :host_id, presence: true
  validates :status, presence: true
  validates :theme, presence: true

  after_create :create_host_team_relation
  after_create :send_notifications
  
  def create_host_team_relation
    r = TeamRelation.new
    r.user_id = self.host_id
    r.battle_id = self.id
    r.team = "host_team"
    r.status = 'joined'
    r.save
  end

  def send_notifications
	  self.users.each do |user|
		  # Send email/app notifications
		  # Notification.create!(:notification_type => 'invite', :battle_id => self.id, :sender_id => self.host_id, :receiver_id => user.id)
	  end
  end
  
  def status?(value)
    self.status == value
  end
end