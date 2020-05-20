class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      flash[:success] = "ログインに成功しました。"
      log_in user
      redirect_to root_url
    else
      flash.now[:danger] = "ユーザ名又はパスワードが違います"
      render 'new'
    end
  end
end
