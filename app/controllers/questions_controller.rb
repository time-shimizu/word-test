class QuestionsController < ApplicationController
  before_action :logged_in_user

  def index
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
  end

  def update
  end

  def destroy
  end

  private

    def logged_in_user
      redirect_to login_path unless logged_in?
    end

    def question_params
      params.require(:question).permit(:question, :description)
    end
end
