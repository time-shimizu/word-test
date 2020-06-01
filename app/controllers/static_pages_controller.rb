class StaticPagesController < ApplicationController
  def home
    rand_number = Question.all.map(&:id).sample
    @question = Question.find(rand_number)
  end
end
