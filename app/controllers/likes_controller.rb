class LikesController < CarsController
	include ApplicationHelper
	before_filter :find_car
	def create 
		@like = Like.new
		@like.user = current_user
		@like.car = @car
		if !current_user.has_liked?(@car) && @like.save
			redirect_to @car, notice: "You liked this car!"
		else
			redirect_to @car, alert: "Sorry, you could not like!"
		end
		
	end

	def destroy
		@like = Like.find(params[:id])
		if @like.destroy
			redirect_to @car, notice: "You unliked this car!"
		else
			redirect_to @car, alert: "Sorry, you could not unlike!"
		end
	end
end
