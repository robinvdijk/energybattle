class SingleBattle < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :opponent_id, presence: true
  validates :winner_id, presence: true

  def current_user
    "1"
  end
end
