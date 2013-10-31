class SingleBattle < ActiveRecord::Base
  has_many :users, through: :team_relations

  validates :host_id, presence: true
end
