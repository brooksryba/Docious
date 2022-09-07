# frozen_string_literal: true

require 'test_helper'

module Mutations
  class DisableUserTest < ActiveSupport::TestCase
    def perform(user, args = {})
      Mutations::DisableUser.new(object: nil, field: nil, context: { current_user: user }).resolve
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

    test 'disable existing user' do
      user = create_user
      perform(user)

      assert user.reload.deleted_at.present?
    end
  end
end
