class Question < ApplicationRecord
  validates, :question, presence: true
  validates, :descriprion, presence: true
end
