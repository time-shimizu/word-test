class QuestionSimilarWordsController < ApplicationController
  before_action :logged_in_user
  def destroy
    QuestionSimilarWord.find(params[:id]).destroy
    flash[:success] = "類似単語を削除しました"
    redirect_to questions_path
  end
end
