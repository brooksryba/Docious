# frozen_string_literal: true

module ConversationInteractions
end

module Interaction
  class StartConversation < BaseInteraction
    def self.execute(author_id:, recipient_id:)
      Conversation.create!(author_id:, recipient_id:)
    end
  end

  class SendMessage < BaseInteraction
    def self.execute(id:, author_id:, content:)
      messages = Conversation.find(id).messages
      messages.create!(author_id:, content:)
    end
  end
end
