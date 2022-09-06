# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :auth_user, mutation: Mutations::AuthUser
    field :create_user, mutation: Mutations::CreateUser
  end
end
