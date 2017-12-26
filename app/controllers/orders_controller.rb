class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
 
    @room = Room.find(params[:room_id])
    @hotel =Room.find(params[@room.hotel_id])
    @orders = @room.orders.all
    @date
    @orders.each do |order|
            
    end
  end

  # GET /orders/new
  def new
    @room = Room.find(params[:room_id])
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
  
    @room = Room.find(params[:room_id])
    @order = @room.orders.create(order_params)
    @order.user_id = current_user.id

    respond_to do |format|
      if @order.save


        format.html { redirect_to hotel_room_path(@room.hotel_id,@room.id)}
        format.json { render :show, status: :created, location: @order }

      else
        format.html { redirect_to hotel_room_path(@room.hotel_id,@room.id), notice: 'Order not null' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end
    def set_order
      @order = Order.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:form, :to, :user_id, :room_id)
    end
end
