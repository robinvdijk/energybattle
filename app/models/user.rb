class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :battles, through: :team_relations
  has_many :readings
  has_many :team_relations
  has_many :notifications, :foreign_key => :receiver_id
  validates :first_name, presence: true
end
