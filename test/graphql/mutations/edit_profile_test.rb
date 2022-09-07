# frozen_string_literal: true

require 'test_helper'

module Mutations
  class EditProfileTest < ActiveSupport::TestCase
    def perform(user, args = {})
      Mutations::EditProfile.new(object: nil, field: nil, context: { current_user: user }).resolve(**args)
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

    def create_profile(user)
      Profile.create!(
        user_id: user.id,
        nickname: 'Foo',
        biography: 'Bar',
        interests: []
      )
    end

    test 'edit existing user preferences' do
      user = create_user
      create_profile(user)
      perform(user, { nickname: 'Baz', biography: 'Bat', interests: [] })

      assert_equal user.profile.nickname, 'Baz'
      assert_equal user.profile.biography, 'Bat'
    end
  end
end
