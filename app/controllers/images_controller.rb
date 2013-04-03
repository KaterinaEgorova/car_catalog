class ImagesController < CarsController
	before_filter :find_car
	def show
		@image = Image.find(params[:id])
		@car = @image.car

		 respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
      format.js { render }
    end
	end
end