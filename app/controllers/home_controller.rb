class HomeController < ApplicationController

	def index
    	@cars = Car.all
    	@car = Car.first
	    @comment = Comment.new
	    @like =  ( current_user && current_user.like_for(@car)) || Like.new

	end

	def edit

	end

end