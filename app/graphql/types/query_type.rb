# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :viewer, Types::UserType, null: false,
      description: 'Return the current user'

    field :users, [Types::UserType], null: false,
      description: 'Return a list of people near the user'

    field :interests, [Types::InterestType], null: false,
      description: 'Return a list of interests'

    field :conversations, [Types::ConversationType], null: false,
      description: 'Return a list of conversations'

    def viewer
      context[:current_user]
    end

    def users
      context[:current_user].nearby_users
    end

    def interests
      Interest.all
    end

    def conversations
      context[:current_user].conversations
    end
  end
end
