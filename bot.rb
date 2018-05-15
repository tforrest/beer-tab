require 'telegram/bot'
require './lib/config'
require './lib/commands'

config = Config.new
config.setup_database

token = config.telegram_token


Telegram::Bot::Client.run(token, logger: config.logger) do |bot|
  bot.listen do |message|
    response = Commands.execute(message)
    bot.api.send_message(chat_id: message.chat.id, text: response)
  end
end
