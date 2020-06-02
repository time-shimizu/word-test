class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録に成功しました"
      log_in @user
      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
    @users = User.all
    unless session[:correct].nil? || session[:incorrect].nil? || (session[:correct] == 0 && session[:incorrect] == 0) || session[:correct] + session[:incorrect] < 10
      correct_answer_late = session[:correct]*100 / (session[:correct].to_i + session[:incorrect].to_i)
      scores = @users.map(&:highest_score)
      scores << correct_answer_late
      scores.sort!.reverse!
      flash.now[:success] = "お疲れ様でした！あなたの成績は、#{session[:correct].to_i + session[:incorrect].to_i}問中、#{session[:correct].to_i}問正解。正解率#{correct_answer_late}%で#{scores.index(correct_answer_late) + 1}位でした"
      session[:correct] = 0
      session[:incorrect] = 0
      if current_user.highest_score <= correct_answer_late
        current_user.update_attribute(:highest_score, correct_answer_late)
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
