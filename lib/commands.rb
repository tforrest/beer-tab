require './lib/tab'

# Commands is a single-ton class used to parse and delegate the right
# operations for the right command
class Commands
  class << self
    def select_operation(message)
      parsed_text_array = parse_message_text(message.text)
      slash_command = parsed_text_array[0]
      args = parsed_text_array[1, -1]
      case slash_command
      when 'tab'
        'show tab of user'
      when 'paid'
        'remove a beer from your tab'
      when 'owe'
        'add a beer for a friend on your tab'
      else
        'error not valid'
      end
    end

    private

    def parse_message_text(text)
      split_message = text.split
      raise Exception if split_message.length.zero?
      split_message
    end
  end
end