HireFire::Resource.configure do |config|
  config.dyno(:worker) do
    HireFire::Macro::Bunny::Job.queue('test1', :amqp_url => ENV['CLOUDAMQP_URL'])
  end
end