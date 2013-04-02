module ApplicationHelper
	def formatted_date(date)
		date.strftime("%e %b %Y %H:%m:%S%p")
	end

	def pluralize_second_without_count(count, noun, text = nil)
		if count < -1 or count == 0 or count > 1
			return noun
		end
		return "#{noun.pluralize}#{text}"
	end 
end
