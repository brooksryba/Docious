# frozen_string_literal: true

require 'test_helper'

module Mutations
  class StartConversationTest < ActiveSupport::TestCase
    def perform(user, args = {})
      Mutations::StartConversation.new(object: nil, field: nil, context: { current_user: user }).resolve(**args)
    end

    def create_user(email)
      User.create!(
        first_name: 'Test',
        last_name: 'User',
        birthdate: DateTime.current,
        email:,
        password: '[omitted]'
      )
    end

    test 'send message to conversation' do
      user1 = create_user('email1@example.com')
      user2 = create_user('email2@example.com')
      perform(user1, { recipient_id: user2.id })

      assert_equal user1.conversations.length, 1
      assert_equal user2.conversations.length, 1
    end
  end
end
