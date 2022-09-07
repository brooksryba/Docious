# frozen_string_literal: true

module Types
  class TokenType < Types::BaseObject
    field :user, Types::UserType
    field :token, String
  end
end
