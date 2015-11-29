HireFire::Resource.configure do |config|
  config.dyno(:worker) do
    HireFire::Macro::Bunny.queue("test1", :connection => ENV['CLOUDAMQP_URL'])
  end
end