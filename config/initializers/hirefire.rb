HireFire::Resource.configure do |config|
  config.dyno(:worker) do
    HireFire::Macro::Bunny::Job.queue(mapper: :active_record)
  end
end