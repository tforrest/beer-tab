require './lib/tab'

# Commands is a single-ton class used to parse and delegate the right
# operations for the right command
class Commands
  class << self
    def execute(message)
      parsed_text_array = parse_message_text(message.text)
      slash_command = parsed_text_array[0]
      args = parsed_text_array[1, -1]
      case slash_command
      when '/tab'
        'Show tab of user'
      when '/paid'
        'Remove a beer from your tab'
      when '/owe'
        'Add a beer for a friend on your tab'
      when '/commands'
        'Show the list of commands '
      else
        'Not a valid command :) or an error occurred! Yikes!'
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