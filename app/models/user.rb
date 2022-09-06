# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_one :preference

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  attribute :latlon, :st_point, srid: 4326

  enum :group, { basic: 0, moderator: 1, admin: 2 }

  def admin?
    group == 'admin'
  end
end
