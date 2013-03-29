module ApplicationHelper
	def formatted_date(date)
		date.strftime("%e %b %Y %H:%m:%S%p")
	end
end
