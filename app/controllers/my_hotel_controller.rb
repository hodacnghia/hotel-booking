class MyHotelController < ApplicationController
  def index
    @user = current_user
    @hotels = @user.hotels.all
  end
end
