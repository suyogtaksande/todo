class Task < ApplicationRecord
	validates_presence_of :title, :content, :due_date
	attr_accessor :email

	def email
	  @email
	end

	def email=(value)
	  @email = value
	end

end
