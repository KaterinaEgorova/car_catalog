require 'google_chart'

class CarsController < ApplicationController
  before_filter :authenticate_user! , except: [:index,:show,:search, :sort]
  before_filter :find_car, only: [:show, :edit, :update, :destroy]
  before_filter :set_is_current_user_admin




  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all.sort_by(&:likes_count).reverse.map

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cars }
    end
  end

  def ratings
    @cars = Car.all.sort_by(&:likes_count).reverse.map
    
    # Need to clean up this code
    # OK for now, prototype code, just needs to work
    bar_1_data = []
    names_array = []
    pc_data = {}

    i = 0
    @cars.each do |car|
      h1 = { car.make + ' ' + car.model => car.likes.count }
      pc_data = pc_data.merge(h1)
      i = i + 1
      if i == 5 
        break;
      end
    end

    # pc.data key, value
    h = pc_data.length * 55 + 50 
    lc = GoogleChart::BarChart.new("700x" + h.to_s, "", :horizontal, false)
      lc.show_legend = false
      lc.axis :x, :color => '333333', :font_size => 10, :alignment => :center, :range => [0,pc_data.values.max]
      lc.axis :y, :color => '333333', :font_size => 20, :alignment => :right, :labels => pc_data.keys
      lc.width_spacing_options(:bar_width => 50, :bar_spacing => 5) 
      lc.data "Cars", pc_data.values, '3caae8'
    
    @chart_url = lc.to_url

    respond_to do |format|
      format.html # ratings.html.erb
      format.json { render json: @chart_url }
    end
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
    @comment = Comment.new
    @like =  ( current_user && current_user.like_for(@car)) || Like.new

    respond_to do |format|
      format.html 
      format.json { render json: @car }
    end
  end

  # GET /cars/new
  # GET /cars/new.json
  def new
    if @is_current_user_admin    
      @car = Car.new
      5.times { @car.images.build } 

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @car }
        end
    elsif
      redirect_to :root, notice: "You must be an admin to create a new car entry"      
    end
  end

  # GET /cars/1/edit
  def edit
    if @is_current_user_admin    
      5.times { @car.images.build } 
    elsif
      redirect_to :root, notice: "You must be an admin to edit the car entry"      
    end
  end

  # POST /cars
  # POST /cars.json
  def create
    if @is_current_user_admin    
      @car = Car.new(params[:car])

      respond_to do |format|
        if @car.save
          format.html { redirect_to @car, notice: 'Car was successfully created.' }
          format.json { render json: @car, status: :created, location: @car }
        else
          format.html { render action: "new" }
          format.json { render json: @car.errors, status: :unprocessable_entity }
        end
      end
    elsif
      redirect_to cars_url, notice: "You must be an admin to create the car entry"      
    end

  end

  # PUT /cars/1
  # PUT /cars/1.json
  def update
    if @is_current_user_admin    
      respond_to do |format|
        if @car.update_attributes(params[:car])
          format.html { redirect_to @car, notice: 'Car was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @car.errors, status: :unprocessable_entity }
        end
      end
    elsif
      redirect_to cars_url, notice: "You must be an admin to update the car entry"      
    end

  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
   if @is_current_user_admin    
      @car.destroy

      respond_to do |format|
        format.html { redirect_to cars_url }
        format.json { head :no_content }
      end
    elsif
      redirect_to cars_url, notice: "You must be an admin to destroy the car entry"      
    end
  end

  def search
    @cars = Car.search_for params[:search_type], params[:search]
  end

  def sort
    @sort_type = params[:sort_type]
    @cars = Car.all_ordered params[:sort_type]
  end  

  private
  def find_car 
    @car = Car.find(params[:car_id] || params[:id])
  end 

  def set_is_current_user_admin
    @is_current_user_admin = (current_user && current_user.is_admin?)
  end  
end
