class NewsController < ApplicationController
  def results
    render json: [1, 2, 3]
  end
end
