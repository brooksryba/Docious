# frozen_string_literal: true

module Interaction
  class BaseInteraction
    def self.run(**args, &)
      execute(**args, &)
    rescue StandardError => e
      puts "Exception: #{e}"
      puts e.backtrace

      raise GraphQL::ExecutionError, 'Internal server error'
    end

    def self.execute(**args, &); end
  end
end

require_relative './conversation_interactions'
require_relative './user_interactions'
