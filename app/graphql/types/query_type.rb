# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :users, [Types::UserType], null: false,
      description: 'Return a list of users' do
        def authorized?(object, args, context)
          context[:current_user]&.admin?
        end
      end

    field :interests, [Types::InterestType], null: false,
      description: 'Return a list of interests'

    def users
      User.all
    end

    def interests
      Interest.all
    end
  end
end
