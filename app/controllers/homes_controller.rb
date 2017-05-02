class HomesController < ApplicationController
  before_action :authenticate!, except: [:index]
  impressionist actions: [:show], unique: [:request_hash]

  # GET /homes
  def index
    @homes = Home.all.order(created_at: :asc).page params[:page]

    if params[:query]
      @homes = Home.search(params[:query]).order(created_at: :asc).page params[:page]
    else
      @homes = Home.all.order(created_at: :asc).page params[:page]
    end
  end

  # GET /homes/1
  def show
    @home = Home.find(params[:id])
  end

  # GET /homes/new
  def new
    @home = Home.new
  end

  # GET /homes/1/edit
  def edit
    @home = Home.find(params[:id])

    unless @home.can_this_user_edit?(current_user)
      redirect_to homes_path, notice: 'You may not edit other users posts.'
      return
    end
  end

  # POST /homes
  def create
    @home = Home.new(home_params)
    @home.created_by = current_user

    if @home.save
      redirect_to @home, notice: 'Home was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /homes/1
  def update
    @home = Home.find(params[:id])

    unless @home.can_this_user_edit?(current_user)
      redirect_to homes_path, notice: 'You may not edit other users posts.'
      return
    end

    if @home.update(home_params)
      redirect_to @home, notice: 'Home was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /homes/1
  def destroy
    @home = Home.find(params[:id])

    unless @home.can_this_user_destroy?(current_user)
      redirect_to homes_path, notice: 'You may not delete other users posts.'
    else
      @home.destroy
      redirect_to homes_url, notice: 'Home listing was successfully destroyed.'
    end
  end

  def favorite
    home = Home.find(params[:id])

    Favorite.create(home: home, user: current_user)
    Rails.logger.debug "FAVORITING"
  end

  def unfavorite
    home = Home.find(params[:id])
    favorite = Favorite.find_by(home: home, user: current_user)
    favorite.destroy

    Rails.logger.debug "UNFAVORITING"
  end

  private

  # Only allow a trusted parameter "white list" through.
  def home_params
    params.require(:home).permit(:address, :city, :state, :zip, :number_bedrooms, :number_bathrooms, :sq_ft, :price, :description, :image, :roof, :parking, :lot_size, :hoa, :hoa_fee, :number_of_floors, :year_built)
  end
end
