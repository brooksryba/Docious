# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :users, [Types::UserType], null: false,
      description: 'Return a list of people near the user'

    field :interests, [Types::InterestType], null: false,
      description: 'Return a list of interests'

    field :conversations, [Types::ConversationType], null: false,
      description: 'Return a list of conversations'

    def users
      User.all
    end

    def interests
      Interest.all
    end

    def conversations
      Conversation.where(recipient_id: context[:current_user]&.id).or(Conversation.where(author_id: context[:current_user]&.id))
    end
  end
end
