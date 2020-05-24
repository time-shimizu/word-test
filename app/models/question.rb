class Question < ApplicationRecord
  validates :question, presence: true
  validates :description, presence: true
  has_many :question_similar_words, dependent: :destroy
  accepts_nested_attributes_for :question_similar_words, reject_if: :all_blank,allow_destroy: true

  class << self
    def search(search)
      if search
        Question.where(['question LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%"])
      else
        Question.all
      end
    end
  end
end
