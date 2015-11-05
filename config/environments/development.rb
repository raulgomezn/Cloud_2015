Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  #config.active_record.migration_error = :page_load
  config.cache_store = :dalli_store, 'localhost',
  { :namespace => 'Unicloud', :expires_in => 1.day, :compress => true }
  
  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  
  config.web_console.whitelisted_ips = '190.69.208.10'
  config.web_console.whitelisted_ips = '157.253.163.53'
  
  # Paperclip
  Paperclip.options[:command_path] = "/usr/bin/"
  
  # Email SES AWS
  config.action_mailer.delivery_method = :ses
  # Email gmail
  # config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  # address: 'email-smtp.us-east-1.amazonaws.com',
  # domain: 'amazonaws.com',
  # port: 587,
  # user_name: '',
  # password: '',
  # authentication: 'login',
  # enable_starttls_auto: true
  # }
  # config.action_mailer.perform_deliveries = true
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  # address:              'smtp.gmail.com',
  # port:                 587,
  # domain:               'gmail.com',
  # user_name:            ENV['gmail_username'],
  # password:             ENV['gmail_password'],
  # authentication:       'plain',
  # enable_starttls_auto: true  }
  
  # Paperclip (for Amazon) 
  config.paperclip_defaults = {
  :storage => :s3,
  :s3_credentials => {
        :default_url => 'http://s3-sa-east-1.amazonaws.com/unicloudstorage/',
        :s3_host_name => 's3-sa-east-1.amazonaws.com/',
        :bucket => 'unicloudstorage',
        :s3_credentials => {:bucket => ENV['bucket'], :access_key_id => ENV['access_key_id'], :secret_access_key => ENV['secret_access_key']}
    }
  }
  AWS.config(
   access_key_id: ENV['access_key_id'], 
   secret_access_key: ENV['secret_access_key'], 
   region: 's3-sa-east-1'
  )
  #config.action_controller.asset_host = 'd2mmcudnvsg2gc.cloudfront.net'
  #https://d2mmcudnvsg2gc.cloudfront.net/competitions/banners/2/banner.jpg?1445261885
end
