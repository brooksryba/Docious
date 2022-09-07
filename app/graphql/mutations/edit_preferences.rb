# frozen_string_literal: true

module Mutations
  class EditPreferences < BaseMutation
    argument :max_distance, Float
    argument :min_age, Integer
    argument :max_age, Integer

    type Types::UserType

    def resolve(max_distance:, min_age:, max_age:)
      Interaction::UpdateUserPreferences.run(id: context[:current_user].id, max_distance:, min_age:, max_age:)
    end
  end
end
