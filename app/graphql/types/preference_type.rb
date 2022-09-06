# frozen_string_literal: true

module Types
  class PreferenceType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer
    field :max_distance, Float
    field :min_age, Integer
    field :max_age, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
