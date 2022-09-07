# frozen_string_literal: true

require 'singleton'

module Interaction
  class BaseInteraction
    def self.run(**args, &)
      # Reset error collection and execute interactor.
      @errors = []
      result = execute(**args, &)

      # Collect errors and raise if needed.
      raise GraphQL::ExecutionError, @errors.join(', ') if @errors.length.positive?

      result
    rescue GraphQL::ExecutionError => e
      # Allow the user-safe errors from above to pass through.
      raise GraphQL::ExecutionError, e
    rescue StandardError => e
      # Wrap all other errors in a user-safe message.
      puts "Exception: #{e}"
      puts e.backtrace

      raise GraphQL::ExecutionError, 'Internal server error'
    end

    def self.execute(**args, &); end

    include Singleton
  end
end

require_relative './conversation_interactions'
require_relative './user_interactions'
