class User < ActiveRecord::Base
  has_many :battles, through: :team_relations
  has_many :readings
  has_many :team_relations
  has_many :notifications, :foreign_key => :receiver_id
  validates :first_name, presence: true
  

  def self.search(search)
    search.present? and where('first_name LIKE ?', "%#{search}%")
  end
end
