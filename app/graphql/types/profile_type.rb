# frozen_string_literal: true

module Types
  class ProfileType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer
    field :biography, String
    field :nickname, String
    field :interests, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
