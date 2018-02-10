class SessionsController < ApplicationController
  def new
  end
  def create
    mail = params[:session][:email]
    pass = params[:session][:password]
    puts '-----> LLego el email1 '+mail
    puts '-----> LLego el pass1 '+pass
    user = User.where(:email => mail.to_s).first
    if !user.nil?
      puts '-----> LLego el pass de la DB '+ user.id
      mail2 = user.email
      pass2 = user.password
      if pass2 == pass.to_s && mail2 == mail.to_s #&& user.authenticate(params[:session][:password])
        # Log the user in and redirect to the user's show page.
        puts '-----> If'
        log_in user
        @user = user
        redirect_to competitions_url
        #redirect_to user
      else
        puts '-----> Else'
        # Create an error message.
        respond_to do |format|
          format.html { redirect_to login_url, notice: 'Error en el usuario/contraseña.' }
          format.json { head :no_content }
        end
      end
    else
      puts '-----> Else'
        # Create an error message.
        respond_to do |format|
          format.html { redirect_to login_url, notice: 'Error en el usuario/contraseña.' }
          format.json { head :no_content }
      end
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
