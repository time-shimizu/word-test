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
    if session[:correct] != 0 && session[:incorrect] != 0
      correct_answer_late = session[:correct]*100 / (session[:correct] + session[:incorrect])
      flash.now[:success] = "正解数：#{session[:correct]}　不正解数：#{session[:incorrect]}　正答率：　#{correct_answer_late}%"
      session[:correct] = 0
      session[:incorrect] = 0
      if current_user.highest_score.nil?
        current_user.update_attribute(:highest_score, correct_answer_late)
      elsif current_user.highest_score <= correct_answer_late
        current_user.update_attribute(:highest_score, correct_answer_late)
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
