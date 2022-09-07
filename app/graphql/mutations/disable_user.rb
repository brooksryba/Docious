# frozen_string_literal: true

module Mutations
  class DisableUser < BaseMutation
    type Types::UserType

    def resolve
      Interaction::DisableUser.run(id: context[:current_user].id)
    end
  end
end
