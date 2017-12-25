class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:show]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @hotel = Hotel.find(params[:hotel_id])    
    @room = @hotel.rooms.find(params[:id])    
    @orders = @room.orders.all

  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @hotel = Hotel.find(params[:hotel_id])
    @room = @hotel.rooms.create(room_params)


    respond_to do |format|
      if @room.save
        # format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.html { redirect_to hotel_path(@hotel)}
        format.json { render :show, status: :created, location: @room }
      else
        format.html { redirect_to hotel_path(@hotel), notice: 'Room was successfully created.' }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    @hotel = Hotel.find(params[:hotel_id])
    @room = @hotel.rooms.find(params[:id])
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to root}
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @hotel = Hotel.find(params[:hotel_id])
    @room = @hotel.rooms.find(params[:id])
    @room.destroy
    respond_to do |format|
      format.html { redirect_to hotel_path(@hotel) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:type_id, :hotel_id,:price, :bed, :status)
    end
end
