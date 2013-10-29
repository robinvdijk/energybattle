class SingleBattle < ActiveRecord::Base

  validates :host_id, presence: true
  validates :opponent_id, presence: true
end
