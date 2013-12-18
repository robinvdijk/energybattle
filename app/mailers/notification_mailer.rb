class NotificationMailer < ActionMailer::Base
  default from: "info@energybattle.com"
	
	def upload_reading(user)
		@user = user
		mail(to: @user.email, subject: 'Je moet nog een meterstand uploaden')
	end
	
	
end
