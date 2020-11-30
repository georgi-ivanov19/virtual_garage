class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all
  end
  
  def garage
    @cars = Car.all
    if (User.find_by_username(params[:id]))
      @username = params[:id];   
    else
      redirect_to root_path, :notice => 'User not found'
    end
  end

  def search
    if params[:search].present?
      redirect_to garage_path(params[:search]) 
    end
  end
  
  # GET /cars/1
  # GET /cars/1.json
  def show
    @comment = current_user.comments.new
    @comments = Comment.order("id DESC")
  end

  # GET /cars/new
  def new
    @car = current_user.cars.build
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = current_user.cars.build(car_params)
    
    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:make, :model, :engine, :transmission, :description, :image)
    end
end