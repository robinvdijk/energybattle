class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :battle

  def sender
    User.find(self.sender_id) if self.sender_id.present?
  end

  def receiver
    User.find(self.receiver_id) if self.receiver_id.present?
  end
end
