class Question < ApplicationRecord
  validates :question, presence: true
  validates :description, presence: true

  def self.search(search)
    if search
      Question.where(['question LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%"])
    else
      Question.all
    end
  end
end
