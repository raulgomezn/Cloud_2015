class UserMailer < ApplicationMailer
    # Envio de Email cuando crea cuenta
    def welcome_email(user)
        @user = user
        @url  = 'http://unicloud.com/login'
        mail(to: @user.email, subject: t('welcome_for_email'))
    end
    # Envio de Email cuando se actualiza
    def update_email(user)
        @user = user
        @url  = 'http://unicloud.com/login'
        mail(to: @user.email, subject: t('update_info'))
    end
end
