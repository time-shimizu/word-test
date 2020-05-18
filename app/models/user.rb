class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 20}
  validates :password, presence: true, length: {minimum: 4}
  has_secure_password
end
