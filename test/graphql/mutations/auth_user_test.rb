# frozen_string_literal: true

require 'test_helper'

module Mutations
  class AuthUserTest < ActiveSupport::TestCase
    def perform(args = {})
      Mutations::AuthUser.new(object: nil, field: nil, context: { session: {} }).resolve(**args)
    end

    def create_user
      User.create!(
        first_name: 'Test',
        last_name: 'User',
        email: 'email@example.com',
        password: '[omitted]'
      )
    end

    test 'success' do
      user = create_user

      result = perform(
        credentials: {
          email: user.email,
            password: user.password
        }
      )

      assert result[:token].present?
      assert_equal result[:user], user
    end

    test 'failure because no credentials' do
      assert_nil perform
    end

    test 'failure because wrong email' do
      create_user
      assert_nil perform(credentials: { email: 'wrong' })
    end

    test 'failure because wrong password' do
      user = create_user
      assert_nil perform(credentials: { email: user.email, password: 'wrong' })
    end
  end
end
