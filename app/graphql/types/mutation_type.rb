# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :disable_user, mutation: Mutations::DisableUser
    field :edit_profile, mutation: Mutations::EditProfile
    field :edit_preferences, mutation: Mutations::EditPreferences
    field :start_conversation, mutation: Mutations::StartConversation
    field :send_message, mutation: Mutations::SendMessage
    field :auth_user, mutation: Mutations::AuthUser
    field :create_user, mutation: Mutations::CreateUser
  end
end
