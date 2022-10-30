class NotifyMailer < ApplicationMailer

	def notify(tasks, email)
		@tasks = tasks
		mail(to: email, subject: 'Welcome to Ping My Team')
	end
end
