class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 20}, uniqueness: true
  validates :password, presence: true, length: {minimum: 4}, allow_nil: true
  has_secure_password
  default_scope -> {order(highest_score: :desc)}
end
