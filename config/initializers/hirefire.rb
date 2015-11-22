HireFire::Resource.configure do |config|
  config.dyno(:worker) do
    HireFire::Macro::Bunny.queue('test1', :amqp_url => ENV['CLOUDAMQP_URL'])
  end
end