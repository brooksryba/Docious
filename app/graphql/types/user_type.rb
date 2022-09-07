# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String
    field :last_name, String
    field :email, String
    field :latlon, String
    field :profile, Types::ProfileType
    field :preference, Types::PreferenceType do
      def authorized?(obj, _ref, context)
        context[:current_user] == obj
      end
    end
    field :birthdate, GraphQL::Types::ISO8601DateTime, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :pinged_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
