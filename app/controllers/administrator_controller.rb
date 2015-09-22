class AdministratorController < ApplicationController
  def new
    @my_id_param = params[:id]
    ## perform a paginated query:
    @competitions = Competition.paginate(:page => params[:page])
  end
end
