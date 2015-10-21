ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
    server: "email.us-east-1.amazonaws.com",
    access_key_id: ENV['access_key_id'],
    secret_access_key: ENV['secret_access_key']