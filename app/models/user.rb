class User < ActiveRecord::Base
  has_many :single_battles, through: :team_relations
  validates :first_name, presence: true

  def self.search(search)
    search.present? and where('first_name LIKE ?', "%#{search}%")
  end

end
