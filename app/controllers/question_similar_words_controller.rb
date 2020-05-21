class QuestionSimilarWordsController < ApplicationController
  before_action :logged_in_user

  def create
    @question = Question.find(params[:question_similar_word][:question_id])
    @question_similar_word = @question.question_similar_words.new(similar_params)
    if @question_similar_word.save
      flash[:success] = "類似単語を登録できました"
      redirect_to questions_path
    else
      render "questions/edit"
    end
  end

  def destroy
    QuestionSimilarWord.find(params[:id]).destroy
    flash[:success] = "類似単語を削除しました"
    redirect_to questions_path
  end

  private
    def similar_params
      params.require(:question_similar_word).permit(:similar_word)
    end
end
