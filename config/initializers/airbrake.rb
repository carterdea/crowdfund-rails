Airbrake.configure do |config|
  config.project_key = ENV['AIRBRAKE_PROJECT_KEY']
  config.project_id = ENV['AIRBRAKE_PROJECT_ID']
  config.environment = Rails.env
  config.ignore_environments = %w(development test)

end
