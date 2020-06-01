class StaticPagesController < ApplicationController
  def home
    session[:correct] = 0
    session[:incorrect] = 0
    rand_number = Question.all.map(&:id).sample
    @question = Question.find(rand_number)
  end
end
