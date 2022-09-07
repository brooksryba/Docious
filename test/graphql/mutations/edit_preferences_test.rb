# frozen_string_literal: true

require 'test_helper'

module Mutations
  class EditPreferencesTest < ActiveSupport::TestCase
    def perform(user, args = {})
      Mutations::EditPreferences.new(object: nil, field: nil, context: { current_user: user }).resolve(**args)
    end

    def create_user
      User.create!(
        first_name: 'Test',
        last_name: 'User',
        birthdate: DateTime.current,
        email: 'email@example.com',
        password: '[omitted]'
      )
    end

    def create_preferences(user)
      Preference.create!(
        user_id: user.id,
        max_distance: 1.0,
        min_age: 20,
        max_age: 25
      )
    end

    test 'edit existing user preferences' do
      user = create_user
      create_preferences(user)
      perform(user, { max_distance: 2.0, min_age: 25, max_age: 30 })

      assert_equal user.preference.max_distance, 2.0
      assert_equal user.preference.min_age, 25
      assert_equal user.preference.max_age, 30
    end
  end
end
