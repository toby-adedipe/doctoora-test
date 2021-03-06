class UserMailer < ApplicationMailer

	default from: ENV.fetch("EMAIL_USERNAME")

	def refer_email username, email
		@username = username
		mail(to: email, subject: "Doctoora referral by #{username} ")
	end

	def notification_email email_content, email
		@email_content = email_content
		mail(to: email, subject: "New notification from Doctoora")
	end

	def sign_up_confirmation_email email
		mail(to: email, subject: "Thank you for signing up for Doctoora")
	end

end
