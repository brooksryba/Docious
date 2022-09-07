# frozen_string_literal: true

module Mutations
  class AuthUser < BaseMutation
    argument :credentials, Types::AuthProviderCredentialsInput, required: false

    type Types::TokenType

    def resolve(credentials: nil)
      Interaction::AuthUser.run(credentials:)
    end
  end
end
