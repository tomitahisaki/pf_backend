class TestSamplePageJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later

    puts "job is done"
  end
end
