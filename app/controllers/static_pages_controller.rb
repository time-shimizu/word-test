class StaticPagesController < ApplicationController
  def home
    unless Question.count == 0
      rand_number = Question.all.map(&:id).sample
      @question = Question.find(rand_number)
    end
  end
end
