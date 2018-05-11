require 'telegram/bot'
require './lib/config'

config = Config.new
config.setup_database

token = config.telegram_token


Telegram::Bot::Client.run(token, logger: config.logger) do |bot|
  bot.listen do |message|
    user = message.from
    text = message.text
    bot.logger.debug user.username
  end
end
