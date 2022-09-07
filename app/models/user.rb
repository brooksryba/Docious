# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_one :preference
  has_one :profile

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  attribute :latlon, :st_point, srid: 4326

  enum :group, { basic: 0, moderator: 1, admin: 2 }

  def admin?
    group == 'admin'
  end

  def nearby_users # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
    User
      .where(User.arel_table[:latlon].st_distance(latlon).lt(preference&.max_distance))
      .where(birthdate: preference&.max_age&.years&.ago..preference&.min_age&.years&.ago)
      .where(pinged_at: 1.day.ago..DateTime.current)
      .where(deleted_at: nil)
      .where.not(id:)
  end

  def conversations
    Conversation.where(recipient_id: id).or(Conversation.where(author_id: id))
  end
end
