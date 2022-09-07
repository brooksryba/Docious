# frozen_string_literal: true

module Mutations
  class CreateUser < BaseMutation
    # often we will need input types for specific mutation
    # in those cases we can define those input types in the mutation class itself
    class AuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInput, required: false
    end

    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :birthdate, GraphQL::Types::ISO8601DateTime, required: true
    argument :auth_provider, AuthProviderSignupData, required: false

    type Types::UserType

    def resolve(first_name:, last_name:, birthdate:, auth_provider:)
      email = auth_provider&.[](:credentials)&.[](:email)
      password = auth_provider&.[](:credentials)&.[](:password)

      Interaction::CreateUser.run(first_name:, last_name:, birthdate:, email:, password:)
    end
  end
end
