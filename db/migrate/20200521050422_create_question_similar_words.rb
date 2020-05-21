class CreateQuestionSimilarWords < ActiveRecord::Migration[5.2]
  def change
    create_table :question_similar_words do |t|
      t.string :similar_word
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
