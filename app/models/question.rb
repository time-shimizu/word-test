class Question < ApplicationRecord
  validates :question, presence: true
  validates :description, presence: true
end
