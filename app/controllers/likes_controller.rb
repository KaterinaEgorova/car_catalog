class LikesController < CarsController
	before_filter :find_car
	def create 
		@like = Like.new
		@like.user = current_user
		@like.car = @car
		if !current_user.has_liked?(@car) && @like.save
			redirect_to :root, notice: "You liked this car!"
		else
			redirect_to :root, alert: "Sorry, you could not like!"
		end
		
	end

	def destroy
		@like = Like.find(params[:id])
		if @like.destroy
			redirect_to :root, notice: "You unliked this car!"
		else
			redirect_to :root, alert: "Sorry, you could not unlike!"
		end
	end
end
