# frozen_string_literal: true

module Mutations
  class EditProfile < BaseMutation
    argument :id, Integer
    argument :nickname, String
    argument :biography, String
    argument :interests, [Integer], required: false

    type Types::UserType

    def ready?(id:, nickname:, biography:, interests: nil)
      context[:current_user].id == id
    end

    def resolve(id:, nickname:, biography:, interests: nil)
      Interaction::UpdateUserProfile.run(id:, nickname:, biography:, interests:)
    end
  end
end
