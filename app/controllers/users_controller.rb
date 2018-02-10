class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #before_action :admin_user,     only: :destroy
  #before_action :permisos, only: [:show, :edit, :update, :destroy] 
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    puts '<---Create User'
    @user = User.new(params[:user])
    puts "<---Create User email #{@user.email}."
    puts '<---Create User pass'
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: 'Usuario creado satisfactoriamente. Por favor Haga clic en el boton Ingresar para loguearse.' }
        format.json { render :show, status: :created, location: @user }
        # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(@user).deliver
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
        # Tell the UserMailer to send 
        UserMailer.update_email(@user).deliver
      else
        format.html { render :edit }
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
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:firts_name, :second_name, :last_name, :second_last_name, :email, :password) #, :isadmin
  end
  
  private
  #desologuea
  def admin_user
    log_out
  end
  
  def permisos
    if(!logged_in?)
      redirect_to login_path
    end
  end
end
