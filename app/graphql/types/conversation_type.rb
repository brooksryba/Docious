# frozen_string_literal: true

module Types
  class ConversationType < Types::BaseObject
    field :id, ID, null: false
    field :author_id, Integer
    field :recipient_id, Integer
    field :messages, [Types::MessageType]
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
