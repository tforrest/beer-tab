require 'logger'

require './lib/database'

# Config setups everything needs for the telegram bot to run
class Config
  def telegram_token
    token = ENV['BEER_TAB_TOKEN']
    abort 'Error BEER_TAB_TOKEN needs to be set' if token.blank?
    token
  end

  def logger
    Logger.new(STDOUT, Logger::DEBUG)
  end

  def setup_database
    DatabaseConnector.connect
  end
end