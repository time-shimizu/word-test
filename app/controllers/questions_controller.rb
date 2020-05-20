class QuestionsController < ApplicationController
  before_action :logged_in_user

  def index
    @questions = Question.search(params[:search])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "単語の登録に成功しました"
      redirect_to questions_path
    else
      render 'new'
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      flash[:success] = "単語編集が完了しました。"
      redirect_to questions_path
    else
      render 'edit'
    end
  end

  def destroy
    Question.find(params[:id]).destroy
    flash[:success] = "単語を削除しました"
    redirect_to questions_path
  end

  private

    def logged_in_user
      redirect_to login_path unless logged_in?
    end

    def question_params
      params.require(:question).permit(:question, :description)
    end
end