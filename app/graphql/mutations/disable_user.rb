# frozen_string_literal: true

module Mutations
  class DisableUser < BaseMutation
    argument :id, Integer, required: true

    type Types::UserType

    def ready?(id:)
      context[:current_user].id == id
    end

    def resolve(id:)
      Interaction::DisableUser.run(id:)
    end
  end
end
