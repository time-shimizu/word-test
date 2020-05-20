class QuestionsController < ApplicationController
  before_action :logged_in_user

  def index
  end

  def new
  end

  def create
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
end
