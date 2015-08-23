

Lita.configure do |config|
  # The name your robot will use.
  config.robot.name = "Lita"

  # The locale code for the language to use.
  # config.robot.locale = :en

  # The severity of messages to log. Options are:
  # :debug, :info, :warn, :error, :fatal
  # Messages at the selected level and above will be logged.
  config.robot.log_level = :info

  # An array of user IDs that are considered administrators. These users
  # the ability to add and remove other users from authorization groups.
  # What is considered a user ID will change depending on which adapter you use.
  # config.robot.admins = ["1", "2"]

  # The adapter you want to connect with. Make sure you've added the
  # appropriate gem to the Gemfile.
  config.robot.adapter = :shell

  ## Example: Set options for the chosen adapter.
  # config.adapter.username = "myname"
  # config.adapter.password = "secret"

  ## Example: Set options for the Redis connection.
  # config.redis.host = "127.0.0.1"
  # config.redis.port = 1234

  ## Example: Set configuration for any loaded handlers. See the handler's
  ## documentation for options.
  # config.handlers.some_handler.some_config_key = "value"
  #
  #
  config.robot.adapter = :slack
  config.robot.admins = [
    'U08FDG5B4', # fuzzy
    'U08FDJLRW', # donald
    'U08FDV02Z', # sam
    'U08FDUMEZ', # caribou
  ]
  config.adapters.slack.token = ENV['HOUSEBOT_SLACK_TOKEN']

  config.handlers.meme.username = 'flashpoint'
  config.handlers.meme.password =  ENV['FLASHPOINT_OBVIOUS_PASSWORD']

  config.handlers.hue.nodejs_color_lookup = true
  config.handlers.hue.nodejs_invocation = "NODE_PATH=$(npm -g root) /usr/bin/nodejs"
end

HANDLER_DIR = File.join(File.dirname(__FILE__), 'handlers')
Dir[File.join(HANDLER_DIR, "*.rb")].each do |f|
  require f
end
