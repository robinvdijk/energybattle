class NotificationMailer < ActionMailer::Base
  default from: "energybattle058@gmail.com"
	
	def upload_reading(user)
		@user = user
		mail(to: @user.email, subject: 'Je moet nog een meterstand uploaden')
	end
	
	
end
