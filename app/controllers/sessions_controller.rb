class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      @user = user
      redirect_to competitions_url
      #redirect_to user
    else
      # Create an error message.
      flash[:danger] = 'Invalid email/password combination'
      #format.html { redirect_to @competition, notice: 'Competition was successfully updated.' }
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
