class TestSamplePageJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # Do something later

    Rails.logger.debug "job is done"
  end
end
