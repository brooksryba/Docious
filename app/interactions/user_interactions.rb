# frozen_string_literal: true

module UserInteractions
end

module Interaction
  class UpdateUser < BaseInteraction
    def self.execute(id:, first_name:, last_name:, email:, birthdate:, password:)
      user = User.find(id)
      user.update!(first_name:, last_name:, email:, birthdate:, password:)
      user
    end
  end

  class UpdateUserProfile < BaseInteraction
    def self.execute(id:, nickname:, biography:, interests:)
      user = User.find(id)
      user.profile.update!(nickname:, biography:, interests:)
      user
    end
  end

  class UpdateUserPreferences < BaseInteraction
    def self.execute(id:, max_distance:, min_age:, max_age:)
      user = User.find(id)
      user.preference.update!(max_distance:, min_age:, max_age:)
      user
    end
  end

  class EnableUser < BaseInteraction
    def self.execute(id:)
      user = User.find(id)
      user.update!(deleted_at: nil)
      user
    end
  end

  class DisableUser < BaseInteraction
    def self.execute(id:)
      user = User.find(id)
      user.update!(deleted_at: DateTime.current)
      user
    end
  end

  class CreateUser < BaseInteraction
    def self.execute(first_name:, last_name:, email:, birthdate:, password:)
      return @errors.push('Email is already taken.') if User.find_by(email:).present?

      User.create!(first_name:, last_name:, email:, birthdate:, password:)
    end
  end

  class AuthUser < BaseInteraction
    def self.execute(credentials:)
      # basic validation
      return unless credentials

      user = User.find_by email: credentials[:email]

      # ensures we have the correct user
      return unless user
      return unless user.authenticate(credentials[:password])

      user.update!(pinged_at: DateTime.current)

      # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      token = crypt.encrypt_and_sign("user-id:#{user.id}")

      { user:, token: }
    end
  end
end
