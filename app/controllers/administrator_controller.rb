class AdministratorController < ApplicationController
  before_action :permisos, only: [:new]
  def new
    @my_id_param = params[:id]
    ## perform a paginated query:
    @competitions = Competition.where(:users_id => @my_id_param).paginate(:page => params[:page], :per_page => 30)
  end
  
  private
  def permisos
    if(!logged_in?)
      redirect_to login_path
    end
  end
end
