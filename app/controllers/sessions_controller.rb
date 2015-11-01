class SessionsController < ApplicationController
  def new
  end
  def create
    mail = params[:session][:email]
    pass = params[:session][:password]
    puts '-----> LLego el email '+mail
    puts '-----> LLego el pass '+pass
    user = User.where(:email => mail.downcase).limit(1)
    puts '-----> LLego el pass de la DB '+user[0].password
    if user[0].password == pass.to_s && user[0].email.to_s == mail.to_s #&& user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      puts '-----> If'
      log_in user[0]
      @user = user[0]
      redirect_to competitions_url
      #redirect_to user
    else
      puts '-----> Else'
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
