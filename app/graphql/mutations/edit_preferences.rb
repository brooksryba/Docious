# frozen_string_literal: true

module Mutations
  class EditPreferences < BaseMutation
    argument :id, Integer
    argument :max_distance, Float
    argument :min_age, Integer
    argument :max_age, Integer

    type Types::UserType

    def ready?(id:, max_distance:, min_age:, max_age:)
      context[:current_user].id == id
    end

    def resolve(id:, max_distance:, min_age:, max_age:)
      Interaction::UpdateUserPreferences.run(id:, max_distance:, min_age:, max_age:)
    end
  end
end
