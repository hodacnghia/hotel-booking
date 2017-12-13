class HotelsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: [:index, :show]
  # GET /hotels
  # GET /hotels.json
  def index
    if params[:term]
      @hotels = Hotel.whose_name_starts_with(params[:term]).paginate(page: params[:page], per_page: 3)
    else
      @hotels = Hotel.all.paginate(page: params[:page], per_page: 3)
    end
  end

  # GET /hotels/1
  # GET /hotels/1.json
  def show
  end

  # GET /hotels/new
  def new

  end

  #SEARCH
  def search
    @hotels = Hotel.search_content_for(params[:query])
  end

  # GET /hotels/1/edit
  def edit
  end

  # POST /hotels
  # POST /hotels.json
  def create

    @hotel.user_id = current_user.id

      if @hotel.save
        
        redirect_to new_hotel_location_path(@hotel.id)

      else
        format.html { render :new }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end

  end

  # PATCH/PUT /hotels/1
  # PATCH/PUT /hotels/1.json
  def update
    respond_to do |format|
      if @hotel.update(hotel_params)
        format.html { redirect_to @hotel, notice: 'Hotel was successfully updated.' }
        format.json { render :show, status: :ok, location: @hotel }
      else
        format.html { render :edit }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotels/1
  # DELETE /hotels/1.json
  def destroy
    @hotel.destroy
    respond_to do |format|
      format.html { redirect_to hotels_url, notice: 'Hotel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.


    # Never trust parameters from the scary internet, only allow the white list through.
    def hotel_params
      params.require(:hotel).permit(:name,:city_id, :description,:price ,:user_id,{picture: []})
    end
end
