# frozen_string_literal: true

module Mutations
  class StartConversation < BaseMutation
    argument :recipient_id, Integer

    type Types::ConversationType

    def ready?(recipient_id:)
      Conversation.find_by(author_id: context[:current_user].id, recipient_id:).nil? &&
        Conversation.find_by(author_id: recipient_id, recipient_id: context[:current_user].id).nil?
    end

    def resolve(recipient_id:)
      Interaction::StartConversation.run(author_id: context[:current_user].id, recipient_id:)
    end
  end
end
