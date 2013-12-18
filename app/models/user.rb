class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :battles, through: :team_relations
  has_many :readings
  has_many :team_relations
  has_many :notifications, :foreign_key => :receiver_id
  validates :name, presence: true

  #Cookie Overflow error with these 3 enabled
  validates :house_type, presence: true, on: :edit
  validates :family_size, presence: true, on: :edit
  validates :parental_approval, presence: true, on: :edit


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
		#user_birthday = auth.extra.raw_info.birthday
		#birthday = Date.strptime(user_birthday, "%d - %m - %Y")
		
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
          name:auth.extra.raw_info.name,
          provider:auth.provider,
          uid:auth.uid,
          email:auth.info.email,
          password:Devise.friendly_token[0,20],
          avatar:auth.info.image,
          #birthday:birthday
        )
      end
    end
  end
	
	def test
		p 'hooi'
	end
		
end
