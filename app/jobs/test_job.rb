class TestJob < ApplicationJob
  queue_as :default

  def perform
    puts 'Start'
    sleep 3
    puts 'End'
    
  end
end
