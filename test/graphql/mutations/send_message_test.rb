# frozen_string_literal: true

require 'test_helper'

module Mutations
  class SendMessageTest < ActiveSupport::TestCase
    def perform(user, args = {})
      Mutations::SendMessage.new(object: nil, field: nil, context: { current_user: user }).resolve(**args)
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

    def create_conversation(user1, user2)
      Conversation.create!(
        recipient_id: user2.id
      )
    end

    test 'send message to conversation' do
      user1 = create_user('email1@example.com')
      user2 = create_user('email2@example.com')
      convo = create_conversation(user1, user2)
      perform(user1, { id: convo.id, content: 'This is a test' })

      assert_equal convo.messages.length, 1
    end
  end
end
