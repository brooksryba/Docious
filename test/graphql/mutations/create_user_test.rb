# frozen_string_literal: true

require 'test_helper'

module Mutations
  class CreateUserTest < ActiveSupport::TestCase
    def perform(args = {})
      Mutations::CreateUser.new(object: nil, field: nil, context: {}).resolve(**args)
    end

    test 'create new user' do
      user = perform(
        first_name: 'Test',
        last_name: 'User',
        auth_provider: {
          credentials: {
            email: 'email@example.com',
            password: '[omitted]'
          }
        }
      )

      assert user.persisted?
      assert_equal user.first_name, 'Test'
      assert_equal user.last_name, 'User'
      assert_equal user.email, 'email@example.com'
    end
  end
end
