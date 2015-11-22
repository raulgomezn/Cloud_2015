require 'bunny'
require 'singleton'

class BunnyClient
  include Singleton

  def publish(msg)
    @bunny ||= setup_bunny
    @bunny.exchange("").publish(msg) 
  end
  
  def read
    @bunny ||= setup_bunny
    payload = @bunny.exchange("").pop
    puts "This is the message: " + payload + "\n\n"
    return payload
  end

  def bunny
    @bunny ||= setup_bunny
  end

  def setup_bunny
    p "setting bunny up"
    bunny = Bunny.new ENV['CLOUDAMQP_URL']
    bunny.start
    bunny.exchange("")
    bunny.queue("test1")
    bunny
  end
end