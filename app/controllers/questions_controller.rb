class QuestionsController < ApplicationController
  before_action :logged_in_user
  before_action :find_question, only: [:edit, :update, :destroy]

  def index
    @questions = Question.search(params[:search])
  end

  def show
    if session[:correct].to_i + session[:incorrect].to_i < 9 || params[:question_id].nil?
      if params[:question_id]
        last_question = Question.find(params[:question_id])
        user_answer = Question.find(params[:question])
        if user_answer.description == last_question.description
          # flash.now[:success] = "正解です。"
          session[:correct] += 1
        else
          # flash.now[:danger] = "不正解です。 正解：#{last_question.description}"
          session[:incorrect] += 1
        end
      else
        session[:correct] = 0
        session[:incorrect] = 0
      end
      # rand_number = Question.all.map(&:id).sample
      # @question = Question.find(rand_number)
      if session[:correct] == 0 && session[:incorrect] == 0
        $wordtests = Question.all.sample(10)
        if $wordtests.size <10
          flash[:danger] = "現在の単語数は#{Question.all.count}個です。問題を10問以上作成してください"
          redirect_to new_question_path
        end
        if QuestionSimilarWord
          nums = QuestionSimilarWord.all.map(&:question_id)
          most_having_similar_id = nums.max_by {|x| nums.count(x)}
          $most_similar_number = Question.find(most_having_similar_id).question_similar_words.count
        end
      end
      @question = $wordtests.shift
      if @question
        @similar_words = @question.question_similar_words
        @questions = (Question.where.not(id: @question.id).sample(2) << @question).shuffle
      else
        render :js => "window.location = '#{root_path}'"
      end
      respond_to do |format|
        format.html
        format.js
      end
    else
      last_question = Question.find(params[:question_id])
      user_answer = Question.find(params[:question])
      if user_answer.description == last_question.description
        session[:correct] += 1
      else
        session[:incorrect] += 1
      end
      render :js => "window.location = '#{users_path}'"
    end
  end

  def new
    @question = Question.new
    @question_similar_word = @question.question_similar_words.build
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
    @question_similar_word = @question.question_similar_words.new
  end

  def update
    if @question.update_attributes(question_params)
      flash[:success] = "単語編集が完了しました。"
      redirect_to questions_path
    else
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    flash[:success] = "単語を削除しました"
    redirect_to questions_path
  end

  private

    def question_params
      params.require(:question).permit(:question, :description,
        question_similar_words_attributes:[:id, :similar_word, :_destroy])
    end

    def find_question
      @question = Question.find(params[:id])
    end
end