# frozen_string_literal: true

module Mutations
  class SendMessage < BaseMutation
    argument :id, Integer
    argument :content, String

    type Types::MessageType

    def ready?(id:, content:)
      Conversation.find_by(id:).present?
    end

    def resolve(id:, content:)
      Interaction::SendMessage.run(id:, author_id: context[:current_user].id, content:)
    end
  end
end
