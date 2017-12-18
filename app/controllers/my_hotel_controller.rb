class MyHotelController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @hotels = @user.hotels.all.paginate(page: params[:page], per_page: 3)
  end
end
