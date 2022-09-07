# frozen_string_literal: true

module Mutations
  class EditProfile < BaseMutation
    argument :nickname, String
    argument :biography, String
    argument :interests, [Integer], required: false

    type Types::UserType

    def resolve(nickname:, biography:, interests: nil)
      Interaction::UpdateUserProfile.run(id: context[:current_user].id, nickname:, biography:, interests:)
    end
  end
end
