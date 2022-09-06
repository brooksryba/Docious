# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :users, [Types::UserType], null: false,
      description: 'Return a list of users' do
        def authorized?(_object, _args, context)
          context[:current_user]&.admin?
        end
      end

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
      Conversation.all
    end
  end
end
