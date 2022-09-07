# frozen_string_literal: true

module Mutations
  class AuthUser < BaseMutation
    argument :credentials, Types::AuthProviderCredentialsInput, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    type Types::TokenType

    def resolve(credentials: nil)
      Interaction::AuthUser.run(credentials:)
    end
  end
end
