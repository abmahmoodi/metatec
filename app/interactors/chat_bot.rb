require 'telegram/bot'
class ChatBot
  include Interactor

  TOKEN = ENV['TELEGRAM_TOKEN']
  PARAM_ERROR = "Please send your remark to get inbound info."

  def call
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.logger.info('Bot has been started')
      bot.listen do |message|
        bot.logger.info('Bot has been listened.')
        begin
          if message.text == '/start'
            bot.api.send_message(chat_id: message.chat.id,
                                 text: "Hello, #{message.from.first_name}\n#{PARAM_ERROR}")
          else
            inbound = InboundInfo.call(remark: message.text)
            response =
              if inbound.error
                inbound.error
              else
                status = inbound.enable ? 'Active' : 'Inactive'
                "Remark: #{inbound.remark}\nDownload: #{inbound.download} MB\nUpload: #{inbound.upload} MB\nTotal: #{inbound.total} MB\nExpire Time: #{inbound.expiryTime}\nStatus: #{status}"
              end
            bot.api.send_message(chat_id: message.chat.id, text: response)
          end
        rescue StandardError => e
          Rails.logger.info(e.message)
          # SendAlarm.call(message: e.message)
        end
      end
    end
  end
end
