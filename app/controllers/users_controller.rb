class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: [:index, :show]


  # GET /users
  # GET /users.json
  def index
    # returns Geocoder::Result object
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new

  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create


    respond_to do |format|
      if @user.save


        ModelMailer.new_record_notification(@user).deliver

        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    successfully_updated = if needs_password?(@user, user_params)
                             @user.update(user_params)
                           else
                             @user.update_without_password(user_params)
                           end

    respond_to do |format|
      if successfully_updated
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private



    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name)
    end
    def needs_password?(user, params)
      params[:password].present?
    end
end
